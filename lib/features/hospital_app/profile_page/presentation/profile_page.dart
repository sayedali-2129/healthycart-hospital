import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/hospital_app/profile_page/presentation/doctor_list_profile/doctor_list.dart';
import 'package:healthycart/features/hospital_app/profile_page/presentation/widget/profile_header_widget.dart';
import 'package:healthycart/features/hospital_app/profile_page/presentation/widget/profile_main_container_widget.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isUserActive = false;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const CustomCurveAppBarWidget(),
          const ProfileHeaderWidget(),
          const Gap(4),
          ProfileMainContainer(
            text: 'Hospital On / Off',
            sideChild: LiteRollingSwitch(
              value: isUserActive,
              width: 80,
              textOn: 'On',
              textOff: 'Off',
              colorOff: Colors.grey.shade400,
              colorOn: BColors.grey,
              iconOff: Icons.block_rounded,
              iconOn: Icons.power_settings_new,
              animationDuration: const Duration(milliseconds: 300),
              onChanged: (bool state) {},
              onDoubleTap: () {},
              onSwipe: () {},
              onTap: () {},
            ),
          ),
          const Gap(4),
          GestureDetector(
            onTap: () {
              EasyNavigation.push(context: context, page: const DoctorProfileList());
            },
            child: const ProfileMainContainer(
                text: 'Doctors List',
                sideChild: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios),
                )),
          ),
          const Gap(4),
          GestureDetector(
            onTap: () {},
            child: const ProfileMainContainer(
                text: 'Bookings & History',
                sideChild: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios),
                )),
          ),
          const Gap(4),
          GestureDetector(
            onTap: () {},
            child: const ProfileMainContainer(
                text: 'Payment History',
                sideChild: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios),
                )),
          ),
        ],
      ),
    );
  }
}
