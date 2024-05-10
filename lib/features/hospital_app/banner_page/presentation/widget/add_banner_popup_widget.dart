import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/features/hospital_app/banner_page/application/add_banner_provider.dart';
import 'package:healthycart/features/hospital_app/banner_page/presentation/widget/add_new_banner.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';

import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class PopupAddBannerDialouge {
  PopupAddBannerDialouge._();
  static final PopupAddBannerDialouge _instance = PopupAddBannerDialouge._();
  static PopupAddBannerDialouge get instance => _instance;

  Future<void> showAddbannerDialouge({
    required BuildContext context,
    required String nameTitle,
    required String buttonText,
    required VoidCallback buttonTap,
    required VoidCallback onAddTap,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddBannerAlertWidget(
            nameTitle: nameTitle,
            buttonTap: buttonTap,
            onAddTap: onAddTap,
            buttonText: buttonText,
          );
        });
  }
}

class AddBannerAlertWidget extends StatelessWidget {
  const AddBannerAlertWidget(
      {super.key,
      required this.nameTitle,
      required this.buttonTap,
      required this.onAddTap,
      required this.buttonText});
  final String nameTitle;
  final VoidCallback buttonTap;
  final VoidCallback onAddTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddBannerProvider>(builder: (context, value, _) {
      return PopScope(
        onPopInvoked: (didPop) {
          value.clearBannerDetails();
        },
        child: AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: (value.imageFile == null)
                        ? AddNewBannerWidget(
                            onTap: onAddTap,
                            height: 120,
                            width: 120,
                            child: const Center(child: Icon(Icons.add)),
                          )
                        : AddNewBannerWidget(
                            height: 200,
                            width: 260,
                            onTap: onAddTap,
                            child: Image.file(
                              value.imageFile!,
                            ),
                          ),
                  ),
                  const Gap(24),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(nameTitle,
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    const Gap(16),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: buttonTap,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: BColors.buttonLightColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          child: (value.fetchLoading)
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Text(buttonText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white))),
                    )
                  ])
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
