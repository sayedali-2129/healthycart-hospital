import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/widgets/add_doctor_bottomsheet.dart';

import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

import '../../../../../core/custom/app_bar/sliver_appbar.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final popup = PopUpAddDoctorBottomSheet.instance;
    return Scaffold(
      body: Consumer<DoctorProvider>(
        builder: (context, doctorProvider, _) {
          return CustomScrollView(
            slivers: [
              const SliverCustomAppbar(
                title: 'General Health',
              ),
              SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (index == 2) {
                        return CustomButton(
                          width: 160,
                          height: 48,
                          onTap: () {
                            popup.showBottomSheet(
                              context: context,
                              aboutController:doctorProvider.aboutController ,
                              doctorNameController:doctorProvider.doctorNameController,
                              doctorFeeController:doctorProvider.doctorFeeController,
                              specializationController:doctorProvider.specializationController,
                              experienceController: doctorProvider.experienceController,
                               qualificationController:doctorProvider.qualificationController,
                              buttonText: 'Save',
                              addTap: () {
                                 doctorProvider
                                      .getImage()
                                      .then((value) => value.fold((failure) {
                                            CustomToast.errorToast(text: failure.errMsg);
                                          }, (imageFile) {
                                            doctorProvider.imageFile = imageFile;
                                          }));
                              },
                              buttonTap: () {
                                if (doctorProvider.imageFile == null) {
                                CustomToast.errorToast(text: 'Pick category image');
                                return;
                              }
                               if (!formKey.currentState!.validate()) {
                                formKey.currentState!.validate();
                                return;
                              }
                              },
                              
                              formKeyValue: formKey,
                            );
                          },
                          text: 'Add Doctor',
                          buttonColor: BColors.darkblue,
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: BColors.white, fontWeight: FontWeight.w500),
                          icon: Icons.add,
                          iconColor: BColors.white,
                        );
                      } else {
                        return Column(
                          children: [
                            PhysicalModel(
                              color: BColors.white,
                              borderRadius: BorderRadius.circular(12),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 96,
                                        width: 96,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                  BImage.logo,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, bottom: 16, left: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 232,
                                              child: Row(
                                                children: [
                                                  const Gap(8),
                                                  Expanded(
                                                    child: Text(
                                                      'Dr Meenakshi Kallara, MBBS,PHD',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Gap(8),
                                            SizedBox(
                                              width: 232,
                                              child: Row(
                                                children: [
                                                  const Gap(8),
                                                  Expanded(
                                                    child: Text(
                                                      'Neurologist',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Gap(4),
                                            SizedBox(
                                              width: 232,
                                              child: Row(
                                                children: [
                                                  const Gap(8),
                                                  Expanded(
                                                    child: Text(
                                                      'Time 11.00AM - 2.30PM',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              color: Colors.green),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(12)
                          ],
                        );
                      }
                    },
                  ))
            ],
          );
        }
      ),
    );
  }
}
