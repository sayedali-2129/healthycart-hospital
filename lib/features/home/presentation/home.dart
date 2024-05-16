import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/bottom_navigation/bottom_nav_widget.dart';
import 'package:healthycart/features/hospital_form_field/application/hospital_form_provider.dart';
import 'package:healthycart/features/home/application/main_provider.dart';
import 'package:healthycart/features/hospital_app/banner_page/presentation/banner_page.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/doctor_category/doctor_category_main.dart';
import 'package:healthycart/features/hospital_app/profile_page/presentation/profile_page.dart';
import 'package:healthycart/features/hospital_app/request_page/application/presentation/request_page.dart';
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
    final mainProvider = context.read<MainProvider>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      mainProvider.userId = FirebaseAuth.instance.currentUser!.uid;
      if (mainProvider.userId != null) {
        await mainProvider.getHospitalDetails();
      } else {}
    });

    super.initState();
  }

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
          height: 28,
          width: 28,
        ),
        unselectedImage: Image.asset(
          BIcon.addDoctorBlack,
          height: 24,
          width: 24,
        ),
      )),
    );
  }
}
