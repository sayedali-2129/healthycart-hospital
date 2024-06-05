
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/firebase_collection.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/hospital_doctor/domain/model/add_doctor_model.dart';
import 'package:healthycart/features/hospital_profile/domain/i_profile_facade.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileFacade)
class IProfileImpl implements IProfileFacade {
  IProfileImpl(this._firebaseFirestore);
  final FirebaseFirestore _firebaseFirestore;

  @override
  FutureResult<List<DoctorAddModel>> getAllDoctorDetails() async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(FirebaseCollections.doctors)
          .orderBy('createdAt')
          .get();
      return right(snapshot.docs
          .map((e) => DoctorAddModel.fromMap(e.data()).copyWith(id: e.id))
          .toList());
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<String> setActiveHospital({
    required bool ishospitalON,
    required String hospitalId,
  }) async {
    final batch = _firebaseFirestore.batch();

    try {

      batch.update(
          _firebaseFirestore
              .collection(FirebaseCollections.hospitals)
              .doc(hospitalId),
          {'ishospitalON': ishospitalON});

   
      if (ishospitalON == true) {
        batch.update(
            _firebaseFirestore
                .collection(FirebaseCollections.counts)
                .doc('htfK5JIPTaZVlZi6fGdZ'),
            {
              'activeHospitals': FieldValue.increment(1),
              'inActiveHospitals': FieldValue.increment(-1)
            });
      } else {
        batch.update(
            _firebaseFirestore
                .collection(FirebaseCollections.counts)
                .doc('htfK5JIPTaZVlZi6fGdZ'),
            {
              'activeHospitals': FieldValue.increment(-1),
              'inActiveHospitals': FieldValue.increment(1)
            });
      }

      await batch.commit();
 

      return right('Hospital status changed.');
    } on FirebaseException catch (e) {

      return left(MainFailure.firebaseException(errMsg: e.code));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
