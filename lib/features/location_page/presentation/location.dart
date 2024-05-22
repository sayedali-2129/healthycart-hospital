import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/location_page/presentation/location_search.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(BImage.lottieLocation, height: 232),
            const Gap(24),
            Text('Tap below to select hospital location.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                    )),
            const Gap(40),
            CustomButton(
              width: double.infinity,
              height: 48,
              onTap: () {
                EasyNavigation.push(
                    context: context, page: const UserLocationSearchWidget());
              },
              text: "Pick Hospital Location",
              buttonColor: BColors.buttonLightColor,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 18, color: BColors.white),
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
