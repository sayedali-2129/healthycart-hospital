import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/model/add_doctor_model.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/model/doctor_category_model.dart';


abstract class IDoctorFacade {
  Future<Either<MainFailure, File>> getImage();
  Future<Either<MainFailure, String>> saveImage({
    required File imageFile,
  });
  Future<Either<MainFailure, void>> deleteImage();
  Future<Either<MainFailure, List<DoctorCategoryModel>>> getDoctorCategoryAll();
  
  Future<Either<MainFailure, List<DoctorCategoryModel>>> getHospitalDoctorCategory({required List<String> categoryIdList});


  Future<Either<MainFailure, DoctorCategoryModel>> updateHospitalDetails({
    required String hospitalId,
    required DoctorCategoryModel category,
  });

  Future<Either<MainFailure, DoctorCategoryModel>> deleteCategory({
    required String userId,
    required DoctorCategoryModel category,
  });

    Future<Either<MainFailure, bool>> checkDoctorInsideCategory({
    required String categoryId,
    required String hospitalId, 
  });

  Future<Either<MainFailure,DoctorAddModel>> addDoctor({
    required DoctorAddModel doctorData,
  });

  Future<Either<MainFailure, List<DoctorAddModel>>> getDoctor({
    required String categoryId,
  });
}
