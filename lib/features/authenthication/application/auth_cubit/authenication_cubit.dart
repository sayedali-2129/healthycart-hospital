import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/utils/constants/enums.dart';
import 'package:injectable/injectable.dart';

part 'authenication_state.dart';
part 'authenication_cubit.freezed.dart';

@injectable
class AuthenicationCubit extends Cubit<AuthenicationState> {
  AuthenicationCubit(this.iAuthFacade) : super(AuthenicationState.initial());

  final IAuthFacade iAuthFacade;

  void verification(String phoneNo) {
    emit(state.copyWith(loading: true));

    iAuthFacade.verifyPhoneNumber(phoneNo).listen((result) {
      emit(state.copyWith(failureOrSuccessOption: some(result)));
    });
  }

  void clearFailureOrSuccess() {
    emit(state.copyWith(failureOrSuccessOption: none()));
    emit(state.copyWith(otpFailureOrSucess: none()));
    emit(state.copyWith(loading: false));
  }

  void otpVerification(String smsCode, String verificationId) {
    emit(state.copyWith(loading: true));
    iAuthFacade
        .verifySmsCode(smsCode: smsCode, verificationId: verificationId,adminType: state.adminType!)
        .then((value) => emit(state.copyWith(otpFailureOrSucess: some(value))));
  }

  void setAdminType(AdminType adminType) {
    emit(state.copyWith(adminType: adminType));
  }
}
