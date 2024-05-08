import 'package:flutter/material.dart';

class CircularAddImageWidget extends StatelessWidget {
  const CircularAddImageWidget({
    super.key,
    required this.addTap,
    required this.iconSize,
    required this.height,
    required this.width,
    required this.radius,
    this.image,
  });
  final VoidCallback addTap;
  final double iconSize;
  final double height;
  final double width;
  final double radius;
  final ImageProvider? image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(radius),
            image: image != null ? DecorationImage(image: image!) : null),
        child:  Center(
            child: (image == null)? const Icon(
          Icons.add_circle_outline_rounded,
          size: 48,
        ) : null), 
      ),
    );
  }
}
