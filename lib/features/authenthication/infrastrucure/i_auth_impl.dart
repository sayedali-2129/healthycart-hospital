import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/firebase_collection.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/hospital_form_field/domain/model/hospital_model.dart';
import 'package:healthycart/utils/constants/enums.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class IAuthImpl implements IAuthFacade {
  IAuthImpl(this._firebaseAuth, this._firestore);
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  @override
  Stream<Either<MainFailure, String>> verifyPhoneNumber(
    String phoneNumber,
  ) async* {
    final StreamController<Either<MainFailure, String>> controller =
        StreamController<Either<MainFailure, String>>();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (err) {
        controller.add(left(MainFailure.invalidPhoneNumber(errMsg: err.code)));
      },
      codeSent: (verificationId, forceResendingToken) {
        //verification id is stored in the state

        controller.add(right(verificationId));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );

    yield* controller.stream;
  }

  @override
  Future<Either<MainFailure, String>> verifySmsCode({
    required String smsCode,
    required String verificationId,
    required AdminType adminType,
  }) async {
    try {
      final PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      await saveUser(
        phoneNo: userCredential.user!.phoneNumber!,
        uid: userCredential.user!.uid,
        adminType: adminType,
      );

      return right(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(MainFailure.invalidPhoneNumber(errMsg: e.code));
    }
  }

  Future<void> saveUser({
    required String uid,
    required String phoneNo,
    required AdminType adminType,
  }) async {
    final user = await _firestore.collection(FirebaseCollections.hospitals).doc(uid).get();
    if (user.data() != null) {
      return;
    } else {
      await _firestore.collection(FirebaseCollections.hospitals).doc(uid).set(HospitalModel.initial()
          .copyWith(phoneNo: phoneNo, adminType: adminType)
          .toMap());
    }
  }
}
