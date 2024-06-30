import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';

class CustomSliverCurveAppBarWidget extends StatelessWidget {
  const CustomSliverCurveAppBarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      pinned: true,
      toolbarHeight: 104,
      backgroundColor: BColors.mainlightColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              height: 40,
              BImage.roundLogo,
              fit: BoxFit.fill,
            ),
            const Gap(12),
            Text(
              'HEALTHY CART',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 1,
                  color: BColors.darkblue,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
