import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/hospital_form_field/domain/model/hospital_model.dart';






// Here we are getting the details according to the admin

abstract class IMainFacade{
        Future<Either<MainFailure,HospitalModel >> getHospitalDetails({
    required String userId,
  });
}