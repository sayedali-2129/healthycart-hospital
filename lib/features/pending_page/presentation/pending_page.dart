import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/authenthication/application/authenication_provider.dart';
import 'package:healthycart/features/pending_page/application/pending_provider.dart';
import 'package:healthycart/features/splash_screen/splash_screen.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PendingPageScreen extends StatelessWidget {
  const PendingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<AuthenticationProvider, PendingProvider>(
          builder: (context, authProvider, pendingProvider, _) {
        if (authProvider.isRequsetedPendingPage == true) {
          EasyNavigation.pushReplacement(
              type: PageTransitionType.bottomToTop,
              context: context,
              page: const SplashScreen());
        }
        return Padding(
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
              const Gap(40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    pendingProvider.reDirectToWhatsApp(
                        message:
                            'Hi, want to know the details of request regarding hospital.');
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
                    'Contact Us',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 18, color: BColors.white),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
