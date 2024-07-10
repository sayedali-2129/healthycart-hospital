import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/bottom_navigation/bottom_nav_widget.dart';
import 'package:healthycart/features/hospital_banner/presentation/banner_page.dart';
import 'package:healthycart/features/hospital_doctor/presentation/doctor_category/doctor_category_main.dart';
import 'package:healthycart/features/hospital_profile/application/profile_provider.dart';
import 'package:healthycart/features/hospital_profile/presentation/profile_screen.dart';
import 'package:healthycart/features/hospital_request_userside/presentation/request_page.dart';
import 'package:healthycart/utils/constants/image/icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, _) {
      return PopScope(
        canPop: provider.canPopNow,
        onPopInvoked: provider.onPopInvoked,
        child: Scaffold(
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
              height: 28,
              width: 28,
            ),
            unselectedImage: Image.asset(
              BIcon.addDoctorBlack,
              height: 24,
              width: 24,
            ),
          ),
        ),
      );
    });
  }
}
