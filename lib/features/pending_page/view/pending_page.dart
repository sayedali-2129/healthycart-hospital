import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/features/home/presentation/home.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';

class PendingPageScreen extends StatelessWidget {
  const PendingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(BImage.lottieReview, height: 232),
            const Gap(24),
            Text(
              'Please wait while our team reviews and accepts your request. Thank you for your patience!',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: BColors.buttonLightColor),
                  icon: const Icon(
                    Icons.headset_mic,
                    color: BColors.white,
                  ),
                  label: Text(
                    'Request a call',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 18, color: BColors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
