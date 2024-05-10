

import 'package:flutter/material.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/image/medical-concept-hospital-building-doctor-260nw-588196298.webp'),
                      fit: BoxFit.fill)),
            ),
          ),
          Positioned.fill(
              child: Container(
            color: Colors.white.withOpacity(.4),
          )),
          Positioned(
            bottom: 48,
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                color: BColors.lightGrey.withOpacity(.7),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'St. George Hospital todupuzha'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontSize: 18,
                              color: BColors.darkblue,
                              fontWeight: FontWeight.w700),
                      maxLines: 3,
                      // textAlign: TextAlign.center,
                    ),
                    Text(
                      '${'Proprietor :'} ${'Venkatesh Kumar'}',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: BColors.darkblue, fontWeight: FontWeight.w700),
                      maxLines: 2,
                      // textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
