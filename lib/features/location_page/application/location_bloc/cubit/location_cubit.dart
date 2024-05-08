import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/services/location_service.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  Future<void> getPermission() async {
    await LocationService.getPermission();
  }

  Future<void> getLocation() async {
    emit(state.copyWith(loading: true));

    final place = await LocationService.getCurrentLocationAddress();

    emit(place.fold(
      (l) => state.copyWith(
        failureOrSuccessOption: some(place),
        loading: false,
      ),
      (r) => state.copyWith(
        failureOrSuccessOption: some(place),
        placemark: r,
        loading: false,
      ),
    ));
  }

  void clearFailureOrSuccess() {
    emit(state.copyWith(failureOrSuccessOption: none()));
  }
}
