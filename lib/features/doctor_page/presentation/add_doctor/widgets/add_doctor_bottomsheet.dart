import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/text_formfield/textformfield.dart';
import 'package:healthycart/core/general/validator.dart';
import 'package:healthycart/features/doctor_page/application/provider/doctor_provider.dart';
import 'package:healthycart/features/doctor_page/presentation/add_doctor/widgets/add_circular_image.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class PopUpAddDoctorBottomSheet {
  PopUpAddDoctorBottomSheet._();
  static final PopUpAddDoctorBottomSheet _instance =
      PopUpAddDoctorBottomSheet._();
  static PopUpAddDoctorBottomSheet get instance => _instance;

  void showBottomSheet({
    required BuildContext context,
    required TextEditingController titleController,
    required String buttonText,
    required VoidCallback buttonTap,
    required VoidCallback addTap,
    required Key formKeyValue,
  }) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: BColors.white,
        showDragHandle: true,
        useSafeArea: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Consumer<DoctorProvider>(builder: (context, value, _) {
            return SizedBox(
              height: 640,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: CircularAddImageWidget(addTap: addTap, iconSize: 48, height: 120, width: 120, radius: 120),
                            ),
                            const Gap(24),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Form(
                                      key: formKeyValue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //School Name
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Doctor Name",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),

                                          TextfieldWidget(
                                            hintText:
                                                'Enter the name eg: Dr Meenakshi',
                                            validator: BValidator.validate,
                                            controller: titleController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),

                                          const Gap(8),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Time slot",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TimePickerSpinnerPopUp(
                                                cancelTextStyle:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                confirmTextStyle:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                iconSize: 24,
                                                timeFormat: 'hh:mm a',
                                                use24hFormat: false,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initTime: DateTime.now(),
                                                onChange: (dateTime) {
                                                  // Implement your logic with select dateTime
                                                },
                                              ),
                                              Text(
                                                'To',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              TimePickerSpinnerPopUp(
                                                cancelTextStyle:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                confirmTextStyle:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                iconSize: 24,
                                                timeFormat: 'hh:mm a',
                                                use24hFormat: false,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initTime: DateTime.now(),
                                                onChange: (dateTime) {
                                                  // Implement your logic with select dateTime
                                                },
                                              ),
                                            ],
                                          ),
                                          const Gap(8),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Doctor Fee",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),
                                          TextfieldWidget(
                                            keyboardType: TextInputType.number,
                                            hintText:
                                                'Enter the amount in rupees eg: 250 ',
                                            validator: BValidator.validate,
                                            controller: titleController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const Gap(8),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Specialization",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),

                                          TextfieldWidget(
                                            hintText:
                                                'Enter the area of specialization',
                                            validator: BValidator.validate,
                                            controller: titleController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const Gap(8),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Experience",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),
                                          TextfieldWidget(
                                            keyboardType: TextInputType.number,
                                            hintText:
                                                'Enter the years of experience eg: 5',
                                            validator: BValidator.validate,
                                            controller: titleController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const Gap(8),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Doctor Fee",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),
                                          TextfieldWidget(
                                            keyboardType: TextInputType.number,
                                            hintText:
                                                'Enter the amount in rupees eg: 250 ',
                                            validator: BValidator.validate,
                                            controller: titleController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const Gap(8),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Qualification",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.black),
                                            ),
                                          ),
                                          TextfieldWidget(
                                            hintText:
                                                'Enter the qualification eg: MBBS,FRCS, etc...',
                                            validator: BValidator.validate,
                                            controller: titleController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const Gap(16),
                                        ],
                                      )),
                                  const Gap(12),
                                  SizedBox(
                                    height: 56,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          buttonTap.call();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                BColors.buttonLightColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16))),
                                        child: (value.fetchLoading)
                                            ? const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 4,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Text(buttonText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ))),
                                  ),
                                ])
                          ],
                        ),
                      )),
                ),
              ),
            );
          });
        });
  }
}


