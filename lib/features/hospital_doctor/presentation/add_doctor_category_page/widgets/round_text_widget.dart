import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/general/cached_network_image.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
import 'package:provider/provider.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
    this.onLongPress,
  });
  final String title;
  final void Function()? onTap;
  final String image;
   final void Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(builder: (context, doctorProvider, _) {
      
        return GestureDetector(
          onTap:(!doctorProvider.onTapBool)? onTap : null,
          onLongPress:(doctorProvider.onTapBool)? onLongPress : null,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: CustomCachedNetworkImage(
                    image: image,
                  ),
                ),
                const Gap(8),
                SizedBox(
                  width: 88,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
