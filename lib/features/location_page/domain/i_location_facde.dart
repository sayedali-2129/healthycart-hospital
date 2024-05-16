import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/location_page/domain/model/location_model.dart';

abstract class ILocationFacade {
  Future<void> getLocationPermisson();
  Future<Either<MainFailure, Placemark>> getCurrentLocationAddress();
  Future<Either<MainFailure, Unit>> setLocationByHospital(
      PlaceMark placeMark);
}
