import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/location_picker/domain/model/location_model.dart';

abstract class ILocationFacade {
  Future<void> getLocationPermisson();
  Future<Either<MainFailure, PlaceMark?>> getCurrentLocationAddress();

  FutureResult<List<PlaceMark>?> getSearchPlaces(String query);

  Future<Either<MainFailure, Unit>> setLocationByHospital(PlaceMark placeMark);

  Future<Either<MainFailure, Unit>> updateUserLocation(PlaceMark placeMark, String userId);
}
