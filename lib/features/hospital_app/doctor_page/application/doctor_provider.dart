import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/keyword_builder/keyword_builder.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/model/add_doctor_model.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/model/doctor_category_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class DoctorProvider extends ChangeNotifier {
  DoctorProvider(this._iDoctorFacade);
  final IDoctorFacade _iDoctorFacade;
/////////////////////////////////////

  ///////////////////////
  ///Image section ---------------------------
  String? imageUrl;
  File? imageFile;
  bool fetchLoading = false;
  bool fetchAlertLoading = false;
  bool onTapBool = false;

  void onTapEditButton() {
    // to change to long press and ontap
    onTapBool = !onTapBool;
    notifyListeners();
  }

  Future<Either<MainFailure, File>> getImage() async {
    final result = await _iDoctorFacade.getImage();
    notifyListeners();
    return result;
  }

  Future<void> saveImage() async {
    if (imageFile == null) {
      return;
    }
    fetchLoading = true;

    /// fetch loading is true because I am using this function along with add function
    notifyListeners();
    final result = await _iDoctorFacade.saveImage(imageFile: imageFile!);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Can't able to save image.");
    }, (imageurl) {
      imageUrl = imageurl;
      notifyListeners();
    });
    return;
  }

//////////////////////////
  /// adding category -----------------------------------------
  ///
  /// radio button
  int? selectedCategoryIndex;
  DoctorCategoryModel? selectedRadioButtonCategoryValue;
  void selectedRadioButton({
    required DoctorCategoryModel result,
    required int index,
  }) {
    selectedRadioButtonCategoryValue = result;
    selectedCategoryIndex = index;
    notifyListeners();
  }

  List<DoctorCategoryModel> doctorCategoryAllList = [];
  List<String> doctorCategoryIdList =
      []; // to get id of category from the doctors list
  List<DoctorCategoryModel> doctorCategoryList = [];
  DoctorCategoryModel? doctorCategory;
  List<DoctorCategoryModel> doctorCategoryUniqueList = [];
////getting category of doctor from admin side
  Future<void> getDoctorCategoryAll() async {
    if (doctorCategoryAllList.isNotEmpty) return;
    fetchAlertLoading = true;
    notifyListeners();
    final result = await _iDoctorFacade.getDoctorCategoryAll();
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Couldn't able to fetch category");
      fetchLoading = false;
      notifyListeners();
    }, (categoryAllList) {
      log('Get Category from CategoryAll in provider::::::::::::::::::::${categoryAllList.length}');
      doctorCategoryAllList.addAll(categoryAllList);
      doctorCategoryUniqueList.addAll(doctorCategoryAllList);
    });
    fetchAlertLoading = false;
    notifyListeners();
  }

  Future<void> getHospitalDoctorCategory() async {
    log(doctorCategoryList.toString());
    if (doctorCategoryList.isNotEmpty) return;
    fetchLoading = true;
    notifyListeners();
    final result = await _iDoctorFacade.getHospitalDoctorCategory(
        categoryIdList: doctorCategoryIdList);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Couldn't able to fetch category");
      fetchLoading = false;
      notifyListeners();
    }, (categoryList) {
      doctorCategoryList.addAll(categoryList);
    });
    fetchLoading = false;
    notifyListeners();
  }

  void removingFromUniqueCategoryList() {
    for (var element in doctorCategoryList) {
      doctorCategoryUniqueList.removeWhere((cat) {
        return cat.id == element.id;
      });
      notifyListeners();
    }
  }

  /// update the category in hospital model
  Future<void> updateCategory(
      {required DoctorCategoryModel categorySelected,
      required String hospitalId}) async {
    log('User id in upadting category $hospitalId');

    final result = await _iDoctorFacade.updateHospitalDetails(
        hospitalId: hospitalId, category: categorySelected);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Couldn't able to update category");
    }, (categorymodel) {
      doctorCategoryList.insert(doctorCategoryList.length, categorymodel);
      removingFromUniqueCategoryList();
      notifyListeners();
    });
    return;
  }

///////////////////////
  /// Deleting doctor category-----------------------
  Future<void> deleteCategory(
      {required int index, required DoctorCategoryModel category}) async {
    // check if there is any doctors inside category that is going to be deleted
    final boolResult = await _iDoctorFacade.checkDoctorInsideCategory(
        categoryId: category.id ?? 'No categoryId',
        hospitalId: hospitalId ?? ' No hospital Id is here..');
    boolResult.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Something went wrong,please try again");
    }, (sucess) async {
      if (sucess) {
        CustomToast.errorToast(
            text: "Can't delete, there is doctor's list inside");
      } else {
        final result = await _iDoctorFacade.deleteCategory(
            userId: hospitalId!, category: category);
        result.fold((failure) {
          log('Failure in delete category::::${failure.errMsg}');
          CustomToast.errorToast(
              text: "Can't able to delete the category,please try again.");
        }, (category) {
          doctorCategoryList.removeAt(index);
          doctorCategoryUniqueList.add(category);
          CustomToast.sucessToast(text: 'Sucessfully deleted.');
          notifyListeners();
        });
      }
    });
  }

/////////////////////////////////////////////
//        Doctor  Section---------------------------------
  String? hospitalId =
      FirebaseAuth.instance.currentUser?.uid; // user id and hospital id is same

  /// these both are used in the category also to check wheather the user
  String? categoryId;
  String? selectedDoctorCategoryText;
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController doctorFeeController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController aboutDoctorController = TextEditingController();
  String? timeSlotListElement1;
  String? timeSlotListElement2;
  String? availableTotalTimeSlot1;
  String? availableTotalTimeSlot2;
  String? availableTotalTime;
  List<String>? timeSlotListElementList = [];
// adding the userId/hospital and categoryId
  void selectedCategoryDetail({
    required String catId,
    required String catName,
  }) {
    categoryId = catId;
    selectedDoctorCategoryText = catName;
    specializationController.text =
        selectedDoctorCategoryText ?? 'No category selected';
    notifyListeners();
  }

  ///setting total time slot
  void totalAvailableTimeSetter(String time) {
    availableTotalTime = time;
    notifyListeners();
  }

// setting available time slot
  void addTimeslot() {
    if (timeSlotListElement1 != null && timeSlotListElement2 != null) {
      timeSlotListElementList!
          .add('$timeSlotListElement1 - $timeSlotListElement2');
      timeSlotListElement1 = null;
      timeSlotListElement2 = null;
      notifyListeners();
    } else {
      CustomToast.errorToast(text: 'Select both start and end time');
      notifyListeners();
    }
  }

// removing timeslot from the list
  void removeTimeSlot(int index) {
    timeSlotListElementList!.removeAt(index);
    notifyListeners();
  }

  ///////////////////////////////////// 1.)  Adding doctor----------
  ///
  List<DoctorAddModel> doctorList = [];
  DoctorAddModel? doctorDetails;
  List<DoctorAddModel> doctorData = [];

  Future<void> addDoctorDetail() async {
    fetchLoading = true;
    notifyListeners();
    doctorDataList();
    final result = await _iDoctorFacade.addDoctor(doctorData: doctorDetails!);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(
          text: "Couldn't able to add doctor, please try again.");
    }, (doctorReturned) {
      CustomToast.sucessToast(text: "Added doctor sucessfully");
      doctorList.insert(doctorList.length, doctorReturned);
      clearDoctorDetails();
      notifyListeners();
    });
    fetchLoading = false;
    notifyListeners();
  }

  List<String> keywordDoctorBuilder() {
    List<String> combinedKeyWords = [];
    combinedKeyWords.addAll(keywordsBuilder(doctorNameController.text));
    combinedKeyWords.addAll(keywordsBuilder(specializationController.text));
    return combinedKeyWords;
  }

  void doctorDataList() {
    doctorDetails = DoctorAddModel(
        categoryId: categoryId,
        hospitalId: hospitalId,
        id: const Uuid().v4(),
        doctorImage: imageUrl,
        doctorName: doctorNameController.text,
        doctorTotalTime: availableTotalTime,
        doctorTimeList: timeSlotListElementList,
        doctorFee: int.parse(doctorFeeController.text),
        doctorSpecialization: specializationController.text,
        doctorExperience: int.parse(experienceController.text),
        doctorQualification: qualificationController.text,
        doctorAbout: aboutController.text,
        createdAt: Timestamp.now(),
        keywords: keywordDoctorBuilder());
    notifyListeners();
  }

  void clearDoctorDetails() {
    imageFile = null;
    availableTotalTimeSlot2 = null;
    availableTotalTimeSlot1 = null;
    availableTotalTime = null;
    doctorNameController.clear();
    doctorFeeController.clear();
    experienceController.clear();
    qualificationController.clear();
    aboutController.clear();
    timeSlotListElementList?.clear();
    notifyListeners();
    if (imageUrl != null) {
      imageUrl = null;
    }
    notifyListeners();
  }
  ///////////////// 2.)  Getting doctor details according to the category and user-------

  Future<void> getDoctorsData() async {
    fetchLoading = true;
    notifyListeners();
    doctorList.clear();
    final result = await _iDoctorFacade.getDoctor(categoryId: categoryId!);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Couldn't able to fetch doctor's");
    }, (doctors) {
      doctorList.addAll(doctors); //// here we are assigning the doctor
      log('Doctors list Number ::::${doctorList.toString()}');
    });
    fetchLoading = false;
    notifyListeners();
  }
}
