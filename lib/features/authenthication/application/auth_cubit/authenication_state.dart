part of 'authenication_cubit.dart';

@freezed
class AuthenicationState with _$AuthenicationState {
  const factory AuthenicationState({
    required bool loading,
    required Option<Either<MainFailure, String>> failureOrSuccessOption,
    required Option<Either<MainFailure, String>> otpFailureOrSucess,
    required AdminType? adminType,
  }) = _AuthenicationState;

  factory AuthenicationState.initial() => AuthenicationState(
        loading: false,
        failureOrSuccessOption: none(),
        otpFailureOrSucess: none(),
        adminType: null,
      );
}
