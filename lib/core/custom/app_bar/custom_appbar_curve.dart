import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/app_bar/clip_path_appbar_custom.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';

class CustomCurveAppBarWidget extends StatelessWidget {
  const CustomCurveAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: Container(
          width: double.infinity,
          height: 104,
          decoration: BoxDecoration(
            color: BColors.mainlightColor,
          ),
          child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const  Gap(32),
                    Image.asset(
                      height: 40,
                      BImage.roundLogo,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'HEALTHYCART',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: BColors.darkblue, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  const  Gap(32),
                  ],
                ),
            ),
          ), 
          ),
    );
  }
}
