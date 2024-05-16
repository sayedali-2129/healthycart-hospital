import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/firebase_collection.dart';
import 'package:healthycart/core/services/image_picker.dart';
import 'package:healthycart/features/hospital_form_field/domain/i_form_facade.dart';
import 'package:healthycart/features/hospital_form_field/domain/model/hospital_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFormFeildFacade)
class IFormFieldImpl implements IFormFeildFacade {
  IFormFieldImpl(this._repo, this._imageService);
  final FirebaseFirestore _repo;
  final ImageService _imageService;
  @override
  /////////////adding hospital to the collection
  Future<Either<MainFailure, String>> addHospitalDetails(
      {required HospitalModel hospitalDetails, required String userId}) async {
    try {
      hospitalDetails.id = userId;
      await _repo
          .collection(FirebaseCollections.hospitals)
          .doc(userId)
          .update(hospitalDetails.toMap());
      return right('Sucessfully sent to admin');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    }
  }

  @override
  Future<Either<MainFailure, File>> getImage() async {
    return await _imageService.getGalleryImage();
  }

  @override
  Future<Either<MainFailure, String>> saveImage(
      {required File imageFile}) async {
    return await _imageService.saveImage(imageFile: imageFile);
  }

  @override
  Future<Either<MainFailure, HospitalModel>> getHospitalDetails(
      {required String userId}) async {
    try {
      final snapshot = await _repo.collection(FirebaseCollections.hospitals).doc(userId).get();
      return right(HospitalModel.fromMap(snapshot.data()!));
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.toString()));
    }
  }
}