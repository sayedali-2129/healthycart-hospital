import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/utils/constants/enums.dart';

abstract class IAuthFacade {
  //factory IAuthFacade() => IAuthImpl(FirebaseAuth.instance);
  Stream<Either<MainFailure, String>> verifyPhoneNumber(String phoneNumber);
  Future<Either<MainFailure, String>> verifySmsCode({
    required String smsCode,
    required String verificationId,
    required AdminType adminType,
  });
}
