part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    required bool loading,
    required Placemark? placemark,
    required Option<Either<MainFailure, Placemark>> failureOrSuccessOption,
  }) = _LocationState;

  factory LocationState.initial() => LocationState(
        loading: false,
        failureOrSuccessOption: none(),
        placemark: null,
      );
}
