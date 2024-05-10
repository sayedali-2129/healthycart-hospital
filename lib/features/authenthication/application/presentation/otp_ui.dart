import 'dart:async';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/authenthication/application/auth_cubit/authenication_cubit.dart';
import 'package:healthycart/features/authenthication/application/presentation/widget/pinput.dart';
import 'package:healthycart/features/location_page/application/pages/location.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verificationId, required this.phoneNumber});
  final String verificationId;
  final String phoneNumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late int seconds;
  int resendTimer = 30;
  Timer? timer;
  @override
  void initState() {
    seconds = resendTimer;
    setTimer();
    super.initState();
  }

  void setTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenicationCubit, AuthenicationState>(
      listener: (context, state) {
        state.otpFailureOrSucess.fold(
            () => null,
             (failureOrSuccess) {
                  failureOrSuccess.fold((l) {
                    Navigator.pop(context);
                    CustomToast.errorToast(text: l.errMsg);
                    context.read<AuthenicationCubit>().clearFailureOrSuccess();
                  }, (r) {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>  LocationPage(userId: r, phoneNumber: widget.phoneNumber,))),
                      (Route<dynamic> route) =>
                          route is LocationPage && route.currentResult != null,
                    );
                    context.read<AuthenicationCubit>().clearFailureOrSuccess();
                  });
                });
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(32),
              GestureDetector(
                // back to previous page
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Icon(Icons.arrow_back_ios)),
              ),
              const Gap(56),
              SizedBox(
                child: Center(
                  child: Image.asset(height: 260, width: 218, BImage.otpImage),
                ),
              ),
              const Gap(40),
              Text(
                'Verification',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
              ),
              const Gap(16),
              SizedBox(
                  width: 300,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'Please enter the One Time Password we sent on via sms ',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: widget.phoneNumber,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                        ),
                      ],
                    ),
                  )),
              const Gap(40),
              PinputWidget(onSubmitted: (_) {}, controller: otpController),
              const Gap(40),
              CustomButton(
                width: double.infinity,
                height: 48,
                onTap: () {
                  LoadingLottie.showLoading(
                      context: context, text: 'Loading...');
                  log('${otpController.text} ${widget.verificationId}');
                  context.read<AuthenicationCubit>().otpVerification(
                      otpController.text.trim(), widget.verificationId);
                },
                text: 'Verify code',
                buttonColor: BColors.buttonLightColor,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 18, color: BColors.white),
              ),
              const Gap(24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Didn't get OTP ? ",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                )),
                    (seconds == 0)
                        ? TextSpan(
                            text: 'Resend',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Link clicked!'))
                        : TextSpan(
                            text: 'in 00:$seconds',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
