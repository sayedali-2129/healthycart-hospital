import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdSlider extends StatefulWidget {
  const AdSlider({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<AdSlider> createState() => _AdSliderState();
}

class _AdSliderState extends State<AdSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


   // int currentIndex = 0;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: //provider.banners.isEmpty
                // Center(
                //     child: Lottie.asset(
                //     ConstantIcons.lottieProgress,
                //     height: 100,
                //     width: 100,
                //   ))
                Container(
                    clipBehavior: Clip.antiAlias,
                    width: widget.screenWidth,
                    height: 202,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                       ),
                    child: Image.asset(
                      'assets/image/2-math.jpg',
                      fit: BoxFit.fill,
                    )),
          ),
          options: CarouselOptions(
            viewportFraction: 1,
            initialPage: 0,
            autoPlay: true,
            autoPlayCurve: Curves.decelerate,
            onPageChanged: (index, reason) {
              setState(() {
               // currentIndex = index;
              });
            },
          ),
        ),
      
      ],
    );
  }
}




// Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 202,
//           width: screenWidth,
//           decoration: const BoxDecoration(
//             color: Colors.amber,
//             borderRadius: BorderRadius.all(Radius.circular(16)),
//           ),
//         ),
//         Center(
//           child: SvgPicture.asset(
//             ConstantImage.adBannerSampleSvg,
//             width: screenWidth,
//             // height: 202,
//           ),
//         ),
//       ],
//     );