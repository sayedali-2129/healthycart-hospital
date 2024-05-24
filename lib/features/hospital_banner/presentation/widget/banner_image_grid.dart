
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/general/cached_network_image.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({
    super.key,
    required this.indexNumber,
    required this.image,
  });
  final String indexNumber;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill( 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomCachedNetworkImage(image: image)),
            ),
          
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Positioned(
              left: 4,
              top: 4,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: Text(
                  indexNumber,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
              )),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: BColors.lightGrey.withOpacity(.6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const Gap(8),
                const Icon(
                  Icons.mode_edit_outline_outlined,
                  size: 18,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
