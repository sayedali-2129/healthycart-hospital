import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/form_field/domain/model/hospital_model.dart';

abstract class IFormFeildFacade{
  Future<Either<MainFailure,String >> addHospitalDetails({
    required HospitalModel hospitalDetails,
    required String userId,
  });
}