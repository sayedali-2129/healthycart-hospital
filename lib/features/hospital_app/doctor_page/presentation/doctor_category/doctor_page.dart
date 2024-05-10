import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/add_doctor.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/doctor_category/widgets/add_new_round_widget.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/doctor_category/widgets/round_text_widget.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Consumer<DoctorProvider>(builder: (context, doctorProvider, _) {
      return CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomCurveAppBarWidget(),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 120),
              itemBuilder: (context, index) {
                if (index == 4) {
                  return AddNewRoundWidget(
                      title: 'Add New',
                      onTap: () {
                        
                      });
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const AddDoctorScreen())));
                    },
                    child: const VerticalImageText(
                        image: BImage.logo, title: 'General Health'),
                  );
                }
              },
            ),
          )
        ],
      );
    });
  }
}
