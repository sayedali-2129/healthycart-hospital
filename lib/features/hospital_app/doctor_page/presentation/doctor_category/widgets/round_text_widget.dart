


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VerticalImageText extends StatelessWidget {

  const VerticalImageText( {
    super.key, required this.image, required this.title, this.onTap,
  });
  final String  title;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:Colors.black,
                  borderRadius: BorderRadius.circular(56),
                  image: DecorationImage(image: AssetImage(image))
                ),
              ),
             const Gap(8),  
            SizedBox(
              width: 80,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}