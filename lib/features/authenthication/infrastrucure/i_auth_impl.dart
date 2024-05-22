import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/firebase_collection.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class IAuthImpl implements IAuthFacade {
  IAuthImpl(this._firebaseAuth, this._firestore);
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  String? verificationId; // phone verification Id
  int? forceResendingToken;
  final StreamController<Either<MainFailure, HospitalModel>>
      hospitalStreamController =
      StreamController<Either<MainFailure, HospitalModel>>();

  @override
  Stream<Either<MainFailure, bool>> verifyPhoneNumber(
      String phoneNumber) async* {
    final StreamController<Either<MainFailure, bool>> controller =
        StreamController<Either<MainFailure, bool>>();

    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: forceResendingToken,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        log("VERIFICATION FAILD");
        if (e.code == 'invalid-phone-number') {
          controller.add(left(const MainFailure.invalidPhoneNumber(
              errMsg: 'Phone number is not valid')));
        } else {
          controller.add(left(MainFailure.invalidPhoneNumber(errMsg: e.code)));
        }
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        log("CODE SENT 111");
        //verification id is stored in the state
        this.verificationId = verificationId;
        this.forceResendingToken = forceResendingToken;
        controller.add(right(true));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );

    yield* controller.stream;
  }

  @override
  Future<Either<MainFailure, String>> verifySmsCode({
    required String smsCode,
  }) async {
    try {
      final PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
              verificationId: verificationId ?? "", smsCode: smsCode);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      await saveUser(
        phoneNo: userCredential.user!.phoneNumber!,
        uid: userCredential.user!.uid,
      );

      return right(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(MainFailure.invalidPhoneNumber(errMsg: e.code));
    }
  }

  Future<void> saveUser({
    required String uid,
    required String phoneNo,
  }) async {
    final user = await _firestore
        .collection(FirebaseCollections.hospitals)
        .doc(uid)
        .get();
    if (user.data() != null) {
      return;
    } else {
      await _firestore
          .collection(FirebaseCollections.hospitals)
          .doc(uid)
          .set(HospitalModel.initial()
              .copyWith(
                phoneNo: phoneNo,
              )
              .toMap());
    }
  }

  @override
  Stream<Either<MainFailure, HospitalModel>> hospitalStreamFetchData(
      String userId) async* {
    try {
      _firestore
          .collection(FirebaseCollections.hospitals)
          .doc(userId)
          .snapshots()
          .listen((doc) {
        if (doc.exists) {
          log("DATA:${doc.data()}");
          hospitalStreamController.add(
              right(HospitalModel.fromMap(doc.data() as Map<String, dynamic>)));
        }
      });
    } on FirebaseException catch (e) {
      hospitalStreamController
          .add(left(MainFailure.firebaseException(errMsg: e.code)));
    } catch (e) {
      hospitalStreamController
          .add(left(MainFailure.generalException(errMsg: e.toString())));
    }
    yield* hospitalStreamController.stream;
  }

  @override
  void cancelStream() {
    hospitalStreamController.close();
  }

  @override
  Future<Either<MainFailure, String>> hospitalLogOut() async {
    try {
      cancelStream();
      await _firebaseAuth.signOut();
      return right('Sucessfully Logged Out');
    } catch (e) {
      return left(const MainFailure.generalException(errMsg: "Couldn't able to log out"));
    }
  }
}
