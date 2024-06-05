import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/hospital_doctor/domain/model/add_doctor_model.dart';
import 'package:healthycart/features/hospital_doctor/domain/model/doctor_category_model.dart';

abstract class IDoctorFacade {
  FutureResult<File> getImage();
  FutureResult<String>saveImage({
    required File imageFile,
  });
   FutureResult<Unit>deleteImage({
    required String imageUrl,
    required String doctorId,
  });
 FutureResult< List<DoctorCategoryModel>>getDoctorCategoryAll();

   FutureResult<List<DoctorCategoryModel>>
      getHospitalDoctorCategory({
    required List<String> categoryIdList,
  });

   FutureResult<DoctorCategoryModel>updateHospitalDetails({
    required String hospitalId,
    required DoctorCategoryModel category,
  });

  FutureResult<DoctorCategoryModel> deleteCategory({
    required String userId,
    required DoctorCategoryModel category,
  });

   FutureResult<bool>checkDoctorInsideCategory({
    required String categoryId,
    required String hospitalId,
  });

   FutureResult<DoctorAddModel>addDoctorDetails({
    required DoctorAddModel doctorData,
  });

   FutureResult<List<DoctorAddModel>> getDoctorDetails({
    required String categoryId,
    required String hospitalId,
  });

  FutureResult<DoctorAddModel> deleteDoctorDetails({
    required String doctorId,
    required DoctorAddModel doctorData,
  });

  FutureResult<DoctorAddModel> updateDoctorDetails({
    required String doctorId,
    required DoctorAddModel doctorData,
  });
}
