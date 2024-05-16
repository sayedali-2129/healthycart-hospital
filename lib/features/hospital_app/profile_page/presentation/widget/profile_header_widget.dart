import 'package:flutter/material.dart';
import 'package:healthycart/core/general/cached_network_image.dart';
import 'package:healthycart/features/home/application/main_provider.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mainProviderHospitalDetails =
        context.read<MainProvider>().hospitalDetails;
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned.fill(
            
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ClipRRect(
                  child: CustomCachedNetworkImage(
                      image: mainProviderHospitalDetails!.image ?? ''),
                ),
              ),
            ),

          Positioned.fill(
              child: Container(
            color: Colors.white.withOpacity(.4),
          )),
          Positioned(
            bottom: 40,
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                color: BColors.lightGrey.withOpacity(.7),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8, top: 16, bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (mainProviderHospitalDetails.hospitalName ??
                              'Unkown Hospital Name')
                          .toUpperCase(),
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
                      '${'Proprietor :'} ${mainProviderHospitalDetails.ownerName}',
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
