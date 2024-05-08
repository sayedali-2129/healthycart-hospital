import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/form_field/domain/i_form_facade.dart';
import 'package:healthycart/features/form_field/domain/model/hospital_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFormFeildFacade)
class IFormFieldImpl implements IFormFeildFacade {
  IFormFieldImpl(this._repo);
  final FirebaseFirestore _repo;
  @override
  Future<Either<MainFailure, String>> addHospitalDetails(
      {required HospitalModel hospitalDetails, required String userId}) async {
    try {
      await _repo
          .collection('admins')
          .doc(userId)
          .update(hospitalDetails.toMap());
      return right('Sucessfully sent to admin');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    }
  }
}
