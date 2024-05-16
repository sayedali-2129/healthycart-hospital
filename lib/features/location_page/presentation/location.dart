import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/location_page/application/provider/location_provider.dart';
import 'package:healthycart/features/location_page/presentation/location_search.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child:
          Consumer<LocationProvider>(builder: (context, locationProvider, _) {
        return Column(
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
                await locationProvider.getLocationPermisson();
                await locationProvider.getCurrentLocationAddress();
              },
              text: 'Get current location',
              buttonColor: BColors.buttonLightColor,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 18, color: BColors.white),
            ),
            const Gap(16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Choose location manually",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => EasyNavigation.push(
                            context: context,
                            page: const UserLocationSearchWidget())),
                ],
              ),
            )
          ],
        );
      }),
    ));
  }
}
