import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/model/doctor_model.dart';

import 'package:injectable/injectable.dart';

@injectable
class DoctorProvider extends ChangeNotifier {
  DoctorProvider(this.iDoctorFacade);
  final IDoctorFacade iDoctorFacade;
  String? imageUrl;
  File? imageFile;
  bool fetchLoading = false;

  Future<Either<MainFailure, File>> getImage() async {
    final result = await iDoctorFacade.getImage();
    notifyListeners();
    return result;
  }

  Future<void> saveImage() async {
    if (imageFile == null) {
      return;
    }
    final result = await iDoctorFacade.saveImage(imageFile: imageFile!);
    return;
  }

//////////////////////////
  final TextEditingController categoryController = TextEditingController();
  DoctorCategoryModel? doctorCategory;

////add category of doctor
  Future<Either<MainFailure, String>> addCategory() async {
    doctorCategory = DoctorCategoryModel(
        image: imageUrl ?? '',
        category: categoryController.text,
        isCreated: Timestamp.now());
    notifyListeners();
    fetchLoading = true;
    final result = await iDoctorFacade.addCategory(category: doctorCategory!);
    fetchLoading = false;
    clearCategoryDetails();
    notifyListeners();
    return result;
  }

  void clearCategoryDetails() {
    categoryController.clear();
    imageFile = null;
    notifyListeners();
    if (imageUrl != null) {
      imageUrl = null;
    }
    notifyListeners();
  }
///////////////
  ///
// Doctor add section

  final TextEditingController aboutController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController doctorFeeController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
}
