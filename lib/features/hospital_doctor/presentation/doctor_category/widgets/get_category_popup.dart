import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/custom/custom_cached_network/custom_cached_network_image.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
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

    await showDialog(
        context: context,
        builder: (context) {
          return const AddDoctorsCategoryDilogue();
        });
  }
}

class AddDoctorsCategoryDilogue extends StatefulWidget {
  const AddDoctorsCategoryDilogue({
    super.key,
  });

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
        contentPadding: const EdgeInsets.all(16),
        scrollable: true,
        surfaceTintColor: Colors.white,
        backgroundColor: BColors.lightGrey,
        title: Text('Add prefered category',
            style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14)),
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
                    child: ListView.builder(
                      itemCount: value.doctorCategoryUniqueList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 6),
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
                                ),),
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

                    LoadingLottie.showLoading(
                        context: context, text: 'Adding doctor category...');
                    await value
                        .updateCategory(
                      categorySelected: value.selectedRadioButtonCategoryValue!,
                      hospitalId: value.hospitalId ?? '',
                    )
                        .then((result) {
                      value.selectedRadioButtonCategoryValue = null;

                      EasyNavigation.pop(context: context);

                      EasyNavigation.pop(context: context);
                    });
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
