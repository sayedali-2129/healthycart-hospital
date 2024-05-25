import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthycart/core/custom/confirm_alertbox/confirm_alertbox_widget.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/authenthication/application/authenication_provider.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_doctor/presentation/add_doctor_page/add_doctor.dart';
import 'package:healthycart/features/hospital_doctor/presentation/add_doctor_category_page/widgets/add_new_round_widget.dart';
import 'package:healthycart/features/hospital_doctor/presentation/add_doctor_category_page/widgets/get_category_popup.dart';
import 'package:healthycart/features/hospital_doctor/presentation/add_doctor_category_page/widgets/round_text_widget.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final mainProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (doctorProvider.doctorCategoryIdList.isEmpty) {
        doctorProvider.doctorCategoryIdList =
            mainProvider // here we are passing the list of category id in the hospital admin side
                    .hospitalDataFetched!
                    .selectedCategoryId ??
                [];
        await doctorProvider.getHospitalDoctorCategory();
      }
    });

    final PopupDoctorCategoryShower popup = PopupDoctorCategoryShower.instance;
    return Consumer<DoctorProvider>(builder: (context, doctorProvider, _) {
      return CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomCurveAppBarWidget(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hospital Departments',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      doctorProvider
                          .onTapEditButton(); // bool to toggle to edit
                    },
                    icon: doctorProvider.onTapBool
                        ? Text(
                            'Cancel Edit',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                          )
                        : Row(
                            children: [
                              Text(
                                'Edit',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const Gap(4),
                              const Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
          if (doctorProvider.onTapBool)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Long press on the departments below to remove.',
                  style: Theme.of(context).textTheme.labelMedium,
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
                  sliver: SliverGrid.builder(
                    itemCount: doctorProvider.doctorCategoryList.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            mainAxisExtent: 128),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return AddNewRoundWidget(
                            title: 'Add New',
                            onTap: () {
                              //doctorProvider.removingFromUniqueCategoryList();
                              popup.showDoctorCategoryDialouge(
                                context: context,
                              );
                            });
                      } else {
                        final doctorCategory =
                            doctorProvider.doctorCategoryList[index - 1];
                        return VerticalImageText(
                            onTap: () {
                              doctorProvider.selectedCategoryDetail(
                                  catId: doctorCategory.id ?? 'No ID',
                                  catName: doctorCategory.category);
                              EasyNavigation.push(
                                type: PageTransitionType.rightToLeft,
                                context: context,
                                page: const AddDoctorScreen(),
                              );
                            },
                            onLongPress: () {
                              ConfirmAlertBoxWidget.showAlertConfirmBox(
                                  context: context,
                                  titleText: 'Confirm to delete',
                                  subText: "Are you sure you want to delete?",
                                  confirmButtonTap: () async {
                                    await doctorProvider.deleteCategory(
                                        index: index -1, category: doctorCategory);
                                  });
                            },
                            image: doctorCategory.image,
                            title: doctorCategory.category);
                      }
                    },
                  ),
                )
        ],
      );
    });
  }
}
