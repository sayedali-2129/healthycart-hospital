import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/bottom_navigation/bottom_nav_widget.dart';
import 'package:healthycart/features/banner_page/application/view/banner_page.dart';
import 'package:healthycart/features/doctor_page/presentation/doctor_category/doctor_page.dart';
import 'package:healthycart/features/profile_page/application/view/profile_page.dart';
import 'package:healthycart/features/request_page/application/view/request_page.dart';
import 'package:healthycart/utils/constants/image/icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          bottomNavigationBar: BottomNavigationWidget(
        text1: 'Request',
        text2: 'Doctor',
        text3: 'Banner',
        text4: 'Profile',
        tabItems: const [
          RequestScreen(),
          DoctorScreen(),
          BannerScreen(),
          ProfileScreen(),
        ],
        selectedImage: Image.asset(
          BIcon.addDoctor,
          height: 32,
          width: 32,
        ),
        unselectedImage: Image.asset(
          BIcon.addDoctorBlack,
          height: 28,
          width: 28,
        ),
      )),
    );
  }
}
