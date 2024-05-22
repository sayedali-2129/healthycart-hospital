import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/core/custom/keyword_builder/keyword_builder.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/add_hospital_form/domain/i_form_facade.dart';
import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';
import 'package:healthycart/features/location_page/presentation/location.dart';
import 'package:healthycart/utils/constants/enums.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

@injectable
class HosptialFormProvider extends ChangeNotifier {
  HosptialFormProvider(this._iFormFeildFacade);
  final IFormFeildFacade _iFormFeildFacade;

//Image section
  String? imageUrl;
  File? imageFile;
  bool fetchLoading = false;

  Future<Either<MainFailure, File>> getImage() async {
    final result = await _iFormFeildFacade.getImage();
    notifyListeners();
    return result;
  }

  Future<Either<MainFailure, String>> saveImage() async {
    if (imageFile == null) {
      return left(const MainFailure.generalException(
          errMsg: 'Please chek the image selected.'));
    }
    final result = await _iFormFeildFacade.saveImage(imageFile: imageFile!);
    return result;
  }

  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();

  List<String> keywordHospitalBuider() {
    return keywordsBuilder(hospitalNameController.text);
  }

  HospitalModel? hospitalDetail;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  Placemark? placemark;
  AdminType? adminType;
  Future<void> addHospitalForm({required BuildContext context}) async {
    keywordHospitalBuider();
    hospitalDetail = HospitalModel(
      createdAt: Timestamp.now(),
      keywords: keywordHospitalBuider(),
      phoneNo: phoneNumberController.text,
      hospitalName: hospitalNameController.text,
      address: addressController.text,
      placemark: null,
      ownerName: ownerNameController.text,
      uploadLicense: '',
      image: imageUrl,
      adminType: adminType,
      id: userId,
    );

    final result = await _iFormFeildFacade.addHospitalDetails(
        hospitalDetails: hospitalDetail!, userId: userId!);
    clearAllData();
    notifyListeners();
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      Navigator.pop(context);
    }, (sucess) {
      CustomToast.sucessToast(text: sucess);
      Navigator.pop(context);
      EasyNavigation.pushReplacement(
        type: PageTransitionType.bottomToTop,
        context: context,
        page: const LocationPage(),
      );
    });
  }

  void clearAllData() {
    hospitalNameController.clear();
    addressController.clear();
    adminType = null;
    phoneNumberController.clear();
    ownerNameController.clear();
    notifyListeners();
  }
/////////////////////////// pdf-----------
  ///

  File? pdfFile;
  String? pdfUrl;

  FutureResult<File?> getPDF() async {
    final result = await _iFormFeildFacade.getPDF();
    notifyListeners();
    return result;
  }

  FutureResult<String?> savePDF() async {
    if (imageFile == null) {
      return left(const MainFailure.generalException(
          errMsg: 'Please chek the image selected.'));
    }
    final result = await _iFormFeildFacade.savePDF(pdfFile: pdfFile!);
    return result;
  }

  void clearPdf() {
    pdfFile = null;
    notifyListeners();
  }
}
