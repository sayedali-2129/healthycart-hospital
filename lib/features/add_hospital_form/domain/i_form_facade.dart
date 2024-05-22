import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';

abstract class IFormFeildFacade{
  Future<Either<MainFailure,String >> addHospitalDetails({
    required HospitalModel hospitalDetails,
    required String userId,
  });
   Future<Either<MainFailure, File>> getImage();
   Future<Either<MainFailure, String>> saveImage({required File imageFile});
     Future<Either<MainFailure,HospitalModel >> getHospitalDetails({
    required String userId,
  });

  FutureResult<File>getPDF();
  FutureResult<String?>savePDF({required File pdfFile});
}