// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_doctor/presentation/add_doctor/widgets/add_doctor_bottomsheet.dart';
import 'package:healthycart/features/hospital_doctor/presentation/add_doctor/widgets/details_doctor_container.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/custom/app_bar/sliver_appbar.dart';

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
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: CustomButton(
                  width: 160,
                  height: 48,
                  onTap: () {
                    popup.showBottomSheet(
                        context:
                            context, //// adding nag in new doctor adding form from here
                        addImageTap: () {
                          doctorProvider.getImage();
                        },
                        saveButtonTap: () async {
                          if (doctorProvider.imageFile == null) {
                            CustomToast.errorToast(
                                text: "Pick a doctor's image");
                            return;
                          }
                          if (doctorProvider.timeSlotListElementList!.isEmpty ||
                              doctorProvider.availableTotalTime == null) {
                            CustomToast.errorToast(
                                text: 'No available time slot is added');
                            return;
                          }
                          if (!doctorProvider.formKey.currentState!
                              .validate()) {
                            doctorProvider.formKey.currentState!.validate();
                            return;
                          }

                          LoadingLottie.showLoading(
                              context: context, text: 'Please wait...');

                          await doctorProvider.saveImage().then((value) async {
                            await doctorProvider.addDoctorDetail(
                                context: context);
                          });
                        });
                  },
                  text: 'Add Doctor',
                  buttonColor: BColors.darkblue,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: BColors.white, fontWeight: FontWeight.w500),
                  icon: Icons.add,
                  iconColor: BColors.white,
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
                        itemCount: (doctorProvider.doctorList.length),
                        itemBuilder: (context, index) {
                          final doctorListData =
                              doctorProvider.doctorList[index];
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
                                        doctorProvider.getImage();
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
                                                context: context,
                                                index: index,
                                                doctorData: doctorListData);
                                      });
                                },
                                deleteButton: () {
                                  LoadingLottie.showLoading(
                                      context: context,
                                      text: 'Please wait ...');
                                  doctorProvider
                                      .deleteDoctorDetails(
                                          index: index,
                                          doctorData: doctorListData)
                                      .then((value) {
                                    EasyNavigation.pop(context: context);
                                  });
                                },
                              ), // consumer/ provider data is passed here
                              const Gap(12)
                            ],
                          );
                        }))
          ],
        );
      }),
    );
  }
}
