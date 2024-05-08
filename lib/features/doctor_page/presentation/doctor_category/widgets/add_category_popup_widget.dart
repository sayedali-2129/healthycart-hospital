import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/text_formfield/textformfield.dart';
import 'package:healthycart/core/general/validator.dart';
import 'package:healthycart/features/doctor_page/application/provider/doctor_provider.dart';
import 'package:healthycart/features/doctor_page/presentation/add_doctor/widgets/add_circular_image.dart';

import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class PopUpSingleTextDialog {
  PopUpSingleTextDialog._();
  static final PopUpSingleTextDialog _instance = PopUpSingleTextDialog._();
  static PopUpSingleTextDialog get instance => _instance;

  void showSingleTextAddDialog({
    required double addButtonImageWidth,
    required BuildContext context,
    required String nameTitle,
    required String labelTitle,
    required TextEditingController titleController,
    required String buttonText,
    required VoidCallback buttonTap,
    required VoidCallback addTap,
    required Key formKeyValue,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Consumer<DoctorProvider>(builder: (context, value, _) {
            return AlertDialog(
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
                          child: CircularAddImageWidget(
                        addTap: addTap,
                        iconSize: 40,
                        height: 88,
                        width: 88,
                        radius: 88,
                        image: FileImage(value.imageFile!),
                      )),
                      const Gap(24),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(nameTitle,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ),
                            Form(
                                key: formKeyValue,
                                child: TextfieldWidget(
                                  validator: BValidator.validate,
                                  hintText: labelTitle,
                                  controller: titleController,
                                  style:
                                      Theme.of(context).textTheme.labelLarge!,
                                )),
                            const Gap(16),
                            SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    buttonTap.call();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: BColors.buttonLightColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
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
            );
          });
        });
  }
}
