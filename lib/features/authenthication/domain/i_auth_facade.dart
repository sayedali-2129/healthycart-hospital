import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/add_hospital_form_page/domain/model/hospital_model.dart';


abstract class IAuthFacade {
  //factory IAuthFacade() => IAuthImpl(FirebaseAuth.instance);
  Stream<Either<MainFailure, bool>> verifyPhoneNumber(String phoneNumber);
  Future<Either<MainFailure, String>> verifySmsCode({
    required String smsCode,
  });

  Stream<Either<MainFailure, HospitalModel>> hospitalStreamFetchData(
      String userId);

 Future<Either<MainFailure, String>> hospitalLogOut();     
  Future<void> cancelStream();
}
