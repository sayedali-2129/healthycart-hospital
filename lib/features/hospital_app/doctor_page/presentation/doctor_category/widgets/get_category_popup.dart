import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/general/cached_network_image.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/home/application/main_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class PopupDoctorCategoryShower {
  PopupDoctorCategoryShower._();
  static final PopupDoctorCategoryShower _instance =
      PopupDoctorCategoryShower._();
  static PopupDoctorCategoryShower get instance => _instance;

  Future<void> showDoctorCategoryDialouge({
    required BuildContext context,
  }) async {
    //main provider to get user id
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    await showDialog(
        context: context,
        builder: (context) {
          return AddDoctorsCategoryDilogue(mainProvider: mainProvider);
        });
  }
}

class AddDoctorsCategoryDilogue extends StatefulWidget {
  const AddDoctorsCategoryDilogue({
    super.key,
    required this.mainProvider,
  });

  final MainProvider mainProvider;

  @override
  State<AddDoctorsCategoryDilogue> createState() =>
      _AddDoctorsCategoryDilogueState();
}

class _AddDoctorsCategoryDilogueState extends State<AddDoctorsCategoryDilogue> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<DoctorProvider>(context, listen: false)
          .getDoctorCategoryAll();

      _removeSelectedDocter();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(builder: (context, value, _) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(12),
        scrollable: true,
        surfaceTintColor: Colors.white,
        backgroundColor: BColors.lightGrey,
        title: Text('Add prefered category',
            style: Theme.of(context).textTheme.bodyLarge),
        content: (value.fetchAlertLoading)

            /// loading is done here
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: BColors.darkblue,
                  ),
                ),
              )
            : (value.doctorCategoryUniqueList.isEmpty)
                ? SizedBox(
                    height: 200,
                    child: Center(
                      child: Text('No more category available.',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 520,
                    width: MediaQuery.of(context).size.width - 80,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Gap(8);
                      },
                      itemCount: value.doctorCategoryUniqueList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Material(
                            surfaceTintColor: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            elevation: 3,
                            child: SizedBox(
                                height: 64,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 2),
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 64,
                                        width: 64,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: CustomCachedNetworkImage(
                                            image: value
                                                .doctorCategoryUniqueList[index]
                                                .image),
                                      ),
                                    ),
                                    Text(
                                        value.doctorCategoryUniqueList[index]
                                            .category,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                    RadioMenuButton(
                                        value: value
                                            .doctorCategoryUniqueList[index],
                                        groupValue: value
                                            .selectedRadioButtonCategoryValue,
                                        onChanged: (result) {
                                          value.selectedRadioButton(
                                              index: index, result: result!);
                                        },
                                        child: const SizedBox())
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
        actions: [
          (value.doctorCategoryUniqueList.isNotEmpty)
              ? CustomButton(
                  width: double.infinity,
                  height: 48,
                  onTap: () async {
                    if (value.selectedRadioButtonCategoryValue == null) {
                      CustomToast.errorToast(text: 'Please select a category');
                      return;
                    }
                    log('User id in doctorprovider ${widget.mainProvider.userId ?? ''}');

                    LoadingLottie.showLoading(
                        context: context, text: 'Adding doctor category...');
                    await value.updateCategory(
                      categorySelected: value.selectedRadioButtonCategoryValue!,
                      hospitalId: value.hospitalId ?? '',
                    );
                    value.selectedRadioButtonCategoryValue = null;
                    // ignore: use_build_context_synchronously
                    EasyNavigation.pop(context: context);
                    // ignore: use_build_context_synchronously
                    EasyNavigation.pop(context: context);
                  },
                  text: 'Save',
                  buttonColor: BColors.mainlightColor,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                      ),
                )
              : const SizedBox()
        ],
      );
    });
  }

  void _removeSelectedDocter() {
    context.read<DoctorProvider>().removingFromUniqueCategoryList();
  }
}
