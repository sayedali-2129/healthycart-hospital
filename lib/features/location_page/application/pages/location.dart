import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/form_field/application/view/hospital_form.dart';
import 'package:healthycart/features/location_page/application/location_bloc/cubit/location_cubit.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key, required this.userId, required this.phoneNumber});
  final String userId;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state.loading) {
                LoadingLottie.showLoading(
                    context: context, text: 'Getting location...');
              }
              state.failureOrSuccessOption.fold(() => null, (failureOrSucess) {
                failureOrSucess.fold((l) {
                  Navigator.pop(context);
                  errorToast(text: l.errMsg);
                  context.read<LocationCubit>().clearFailureOrSuccess();
                }, (r) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => HospitalFormScreen(
                                place: r,
                                userId: userId, phoneNo: phoneNumber,
                              ))));
                  context.read<LocationCubit>().clearFailureOrSuccess();
                });
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(BImage.lottieLocation, height: 232),
                const Gap(24),
                Text('Tap to get your current location.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                        )),
                const Gap(40),
                CustomButton(
                  width: double.infinity,
                  height: 48,
                  onTap: () async {
                    context.read<LocationCubit>().getPermission();
                    await context.read<LocationCubit>().getLocation();
                  },
                  text: 'Get current location',
                  buttonColor: BColors.buttonLightColor,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 18, color: BColors.white),
                )
              ],
            ),
          )),
    );
  }
}
