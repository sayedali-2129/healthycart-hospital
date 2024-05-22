import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
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
                                    },
                                    saveButtonTap: () async {
                                      if (doctorProvider.imageFile == null) {
                                        CustomToast.errorToast(
                                            text: "Pick doctor's image");
                                        return;
                                      }
                                      if (doctorProvider
                                              .timeSlotListElementList!
                                              .isEmpty ||
                                          doctorProvider.availableTotalTime ==
                                              null) {
                                        CustomToast.errorToast(
                                            text:
                                                'No available time slot is added');
                                        return;
                                      }
                                      if (!doctorProvider.formKey.currentState!
                                          .validate()) {
                                        doctorProvider.formKey.currentState!
                                            .validate();
                                        return;
                                      }

                                      LoadingLottie.showLoading(
                                          context: context,
                                          text: 'Adding doctor details...');
                                      await doctorProvider.saveImage();
                                      await doctorProvider.addDoctorDetail();

                                      // ignore: use_build_context_synchronously
                                      EasyNavigation.pop(context: context);
                                      // ignore: use_build_context_synchronously
                                      EasyNavigation.pop(context: context);
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
                          final doctorListData =
                              doctorProvider.doctorList[index - 1];
                          return Column(
                            children: [
                              DoctorDetailsViewContainerWidget(
                                doctorListData: doctorListData,
                                editButton: () {
                                  doctorProvider.setDoctorEditData(
                                      doctorEditData: doctorListData);
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
                                      },
                                      saveButtonTap: () async {
                                        if (doctorProvider.imageFile == null &&
                                            doctorProvider.imageUrl == null) {
                                          CustomToast.errorToast(
                                              text: "Add doctor's image");
                                          return;
                                        }
                                        if (doctorProvider
                                                .timeSlotListElementList!
                                                .isEmpty ||
                                            doctorProvider.availableTotalTime ==
                                                null) {
                                          CustomToast.errorToast(
                                              text:
                                                  'No available time slot is added');
                                          return;
                                        }
                                        if (!doctorProvider
                                            .formKey.currentState!
                                            .validate()) {
                                          doctorProvider.formKey.currentState!
                                              .validate();
                                          return;
                                        }

                                        LoadingLottie.showLoading(
                                            context: context,
                                            text: 'Editing doctor details...');

                                        if (doctorProvider.imageUrl == null) {
                                          await doctorProvider.saveImage();
                                        }

                                        await doctorProvider
                                            .updateDoctorDetails(
                                                index: index - 1,
                                                doctorData: doctorListData);

                                        // ignore: use_build_context_synchronously
                                        EasyNavigation.pop(context: context);
                                        // ignore: use_build_context_synchronously
                                        EasyNavigation.pop(context: context);
                                      });
                                },
                                deleteButton: () {
                                  doctorProvider.deleteDoctorDetails(
                                      index: index - 1,
                                      doctorData: doctorListData);
                                },
                              ), // consumer/ provider data is passed here
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
