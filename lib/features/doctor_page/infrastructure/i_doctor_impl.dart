import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/services/image_picker.dart';
import 'package:healthycart/features/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/doctor_page/domain/model/doctor_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDoctorFacade)
class IDoctorImpl implements IDoctorFacade {
  IDoctorImpl(this._firestore, this._imageService);
  final FirebaseFirestore _firestore;
  final ImageService _imageService;
 

  @override
  Future<Either<MainFailure, File>> getImage() async {
    return await _imageService.getGalleryImage();
  }

  @override
  Future<Either<MainFailure, String>> saveImage({required File imageFile}) async{
   return await _imageService.saveImage(imageFile: imageFile);
   
  }

 @override
  Future<Either<MainFailure, void>> deleteImage() {
    throw UnimplementedError();
  }

  @override
  Future<Either<MainFailure, String>> addCategory(
      {required DoctorCategoryModel category}) async {
    try {
      // final CollectionReference collectionRef = FirebaseFirestore.instance.collection('yourCollection');
      await _firestore.collection('doctor_category').add(category.toMap());
      return right('Sucessfully saved category');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    }
  }
  

}
