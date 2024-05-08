import 'package:flutter/material.dart';

import 'package:healthycart/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';

class LoadingLottie {
  static  showLoading({required BuildContext context, required String text}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            surfaceTintColor: Colors.transparent,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(BImage.lottieLoading2,fit: BoxFit.fill, height: 144, width: 200),
                Text(text)
              ],
            ),
          );
        });
  }
}
