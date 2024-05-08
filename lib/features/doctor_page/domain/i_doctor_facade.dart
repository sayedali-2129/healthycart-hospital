import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/doctor_page/domain/model/doctor_model.dart';

abstract class IDoctorFacade {
  Future<Either<MainFailure, File>> getImage();
   Future<Either<MainFailure, String>> saveImage({required File imageFile});
   Future<Either<MainFailure, void >> deleteImage();
   Future<Either<MainFailure, String >> addCategory({
    required DoctorCategoryModel category 
   });
}
