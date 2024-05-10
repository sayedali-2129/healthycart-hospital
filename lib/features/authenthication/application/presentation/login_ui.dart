import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/authenthication/application/auth_cubit/authenication_cubit.dart';
import 'package:healthycart/features/authenthication/application/presentation/otp_ui.dart';
import 'package:healthycart/features/authenthication/application/presentation/widget/phone_field.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumberController = TextEditingController();
    String? countryCode;
    return BlocListener<AuthenicationCubit, AuthenicationState>(
      listener: (context, state) {
        state.failureOrSuccessOption.fold(() => null, (failureOrSuccess) {
          failureOrSuccess.fold((l) {
            Navigator.pop(context);
           CustomToast.errorToast(text: l.errMsg);
            context.read<AuthenicationCubit>().clearFailureOrSuccess();
          }, (r) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => OTPScreen(
                          verificationId: r, phoneNumber: '$countryCode${phoneNumberController.text.trim()}',
                        ))));
            context.read<AuthenicationCubit>().clearFailureOrSuccess();
          });
        });
      },
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(80),
                  SizedBox(
                    child: Center(
                      child: Image.asset(
                          height: 260, width: 218, BImage.loginImage),
                    ),
                  ),
                  const Gap(40),
                  Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                  ),
                  const Gap(16),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'Please select your Country code & enter the Phone number. ',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(40),
                  PhoneField(
                    phoneNumberController: phoneNumberController,
                    countryCode: (value) {
                      countryCode = value;
                    },
                  ),
                  const Gap(40),
                  CustomButton(
                    width: double.infinity,
                    height: 48,
                    onTap: () {
                      if (countryCode == null) return;
                      String phoneNumber =
                          '$countryCode${phoneNumberController.text.trim()}';
                      LoadingLottie.showLoading(
                          context: context, text: 'Loading...');
                      context.read<AuthenicationCubit>().verification(phoneNumber);
                    },
                    text: 'Send code',
                    buttonColor: BColors.buttonDarkColor,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 18, color: BColors.white),
                  ),
                  const Gap(24),
                  CustomButton(
                    width: double.infinity,
                    height: 48,
                    onTap: () {
                      
                    },
                    text: 'Skip login',
                    buttonColor: BColors.buttonLightColor,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 18, color: BColors.white),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
