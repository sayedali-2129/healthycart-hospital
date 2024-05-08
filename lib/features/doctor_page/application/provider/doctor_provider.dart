import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/doctor_page/domain/model/doctor_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class DoctorProvider extends ChangeNotifier {
  DoctorProvider(this.iDoctorFacade);
  final IDoctorFacade iDoctorFacade;
  String? imageUrl;
  File? imageFile;
  bool fetchLoading = false;

  final TextEditingController categoryController = TextEditingController();
  DoctorCategoryModel? doctorCategory;

////add category of doctor
  Future<Either<MainFailure, String>> addCategory() async {
    doctorCategory = DoctorCategoryModel(
        image: '',
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
    imageFile == null;
    if (imageUrl != null) {
      imageUrl == null;
    }
    notifyListeners();
  }

  Future<Either<MainFailure, File>> getImage() async {
    final result = await iDoctorFacade.getImage();
    return result;
  }

  Future<Either<MainFailure, String>> saveImage() async {
    if (imageFile == null) {
      return left(MainFailure.generalException(
          errMsg: 'Please chek the image selected.'));
    }
    final result = await iDoctorFacade.saveImage(imageFile: imageFile);
  }
}
