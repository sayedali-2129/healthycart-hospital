import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/services/image_picker.dart';
import 'package:healthycart/features/hospital_banner/domain/i_banner_facade.dart';
import 'package:healthycart/features/hospital_banner/domain/model/hospital_banner_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IBannerFacade)
class IBannerImpl implements IBannerFacade {
  IBannerImpl(this._repo, this._imageService);
  final FirebaseFirestore _repo;
  final ImageService _imageService;

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
  Future<Either<MainFailure, String>> deleteImage() {
    // TODO: implement deleteImage
    throw UnimplementedError();
  }

  @override
  Future<Either<MainFailure, HospitalBannerModel>> addHospitalBanner(
      {required HospitalBannerModel banner}) async {
    try {
      final CollectionReference collRef = _repo.collection('hoapital_banner');
      String id = collRef.doc().id;
      banner.id = id;
      await collRef.doc(id).set(banner.toMap());
      return right(banner.copyWith(id: id));
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailure, List<HospitalBannerModel>>>
      getHospitalBanner() async {
    try {
      final snapshot = await _repo
          .collection('hoapital_banner')
          .orderBy('isCreated', descending: true)
          .get();
      return right([
        ...snapshot.docs
            .map((e) => HospitalBannerModel.fromMap(e.data()).copyWith(id: e.id))
      ]);
    } on FirebaseException catch (e) {
       return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
       return left(MainFailure.firebaseException(errMsg: e.toString()));
    }
  }
}
