import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/hospital_banner/domain/model/hospital_banner_model.dart';

abstract class IBannerFacade {
  FutureResult<File> getImage();
  FutureResult<String> saveImage({required File imageFile});
  FutureResult<Unit> deleteImage({required String imageUrl});
  FutureResult<HospitalBannerModel> addHospitalBanner({
    required HospitalBannerModel banner,
  });
  FutureResult<HospitalBannerModel> deleteHospitalBanner({
    required HospitalBannerModel banner,
  });
  FutureResult<List<HospitalBannerModel>> getHospitalBanner({
    required String hospitalId,
  });
}
