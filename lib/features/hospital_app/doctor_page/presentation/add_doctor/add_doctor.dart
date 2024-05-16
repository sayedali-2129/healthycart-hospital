import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/widgets/add_doctor_bottomsheet.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/widgets/details_doctor_container.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../core/custom/app_bar/sliver_appbar.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timestamp)  {
       context.read<DoctorProvider>().getDoctorsData();
    });

    final popup = PopUpAddDoctorBottomSheet.instance;
    return Scaffold(
      body: Consumer<DoctorProvider>(builder: (context, doctorProvider, _) {
        return CustomScrollView(
          slivers: [
            SliverCustomAppbar(
              title:
                  doctorProvider.selectedDoctorCategoryText ?? 'Doctors List',
              onBackTap: () {
                Navigator.pop(context);
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Doctor's List",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            (doctorProvider.fetchLoading)

                /// loading is done here
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: LinearProgressIndicator(
                          color: BColors.darkblue,
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList.builder(
                      itemCount: (doctorProvider.doctorList.length) + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: CustomButton(
                              width: 160,
                              height: 48,
                              onTap: () {
                                popup.showBottomSheet(
                                    context:
                                        context, //// adding nag in new doctor adding form from here
                                    addImageTap: () {
                                      doctorProvider.getImage().then(
                                          (value) => value.fold((failure) {
                                                CustomToast.errorToast(
                                                    text: failure.errMsg);
                                              }, (imageFile) {
                                                doctorProvider.imageFile =
                                                    imageFile;
                                              }));
                                    });
                              },
                              text: 'Add Doctor',
                              buttonColor: BColors.darkblue,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: BColors.white,
                                      fontWeight: FontWeight.w500),
                              icon: Icons.add,
                              iconColor: BColors.white,
                            ),
                          );
                        } else {
                          final doctorList =
                              doctorProvider.doctorList[index - 1];
                          return Column(
                            children: [
                              DoctorDetailsViewContainerWidget(doctorList: doctorList),
                              const Gap(12)
                            ],
                          );
                        }
                      },
                    ))
          ],
        );
      }),
    );
  }
}
