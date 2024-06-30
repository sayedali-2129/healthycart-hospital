import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

class DateAndTimeTab extends StatelessWidget {
  const DateAndTimeTab({
    super.key,
    required this.text1,
    required this.text2,
    required this.tabWidth,
    required this.gap,
  });
  final String text1;
  final String text2;
  final double tabWidth;
  final double gap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text1,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Gap(gap),
        Container(
          height: 30,
          width: tabWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: BColors.mainlightColor),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text2,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      )),
            ),
          ),
        ),
      ],
    );
  }
}
