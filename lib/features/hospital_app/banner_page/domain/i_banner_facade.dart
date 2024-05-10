import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/hospital_app/banner_page/domain/model/hospital_banner_model.dart';

abstract class IBannerFacade{
    Future<Either<MainFailure, File>> getImage();
    Future<Either<MainFailure, String>> saveImage({required File imageFile});
    Future<Either<MainFailure, String >> deleteImage();
    Future<Either<MainFailure, HospitalBannerModel >> addHospitalBanner({required HospitalBannerModel banner});
    Future<Either<MainFailure, List<HospitalBannerModel> >> getHospitalBanner(); 
}