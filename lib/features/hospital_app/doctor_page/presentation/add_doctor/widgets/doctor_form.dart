import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/divider/divider.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/text_formfield/textformfield.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/general/validator.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/widgets/add_circular_image.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/widgets/doctor_timeslot_selector.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class DoctorAddForm extends StatelessWidget {
  const DoctorAddForm({
    super.key,
    required this.addImageTap,
  });
  final VoidCallback addImageTap;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Consumer<DoctorProvider>(builder: (context, value, _) {
      return PopScope(
        onPopInvoked: (didPop) {
          value.clearDoctorDetails();
        },
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
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
                            child: (value.imageFile == null)
                                ? CircularAddImageWidget(
                                    addTap: addImageTap,
                                    iconSize: 48,
                                    height: 120,
                                    width: 120,
                                    radius: 120)
                                : GestureDetector(
                                    onTap: addImageTap,
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: FileImage(
                                        value.imageFile!,
                                      ),
                                    ),
                                  ),
                          ),
                          const Gap(16),
                          const DividerWidget(text: 'Tap above to add photo'),
                          const Gap(24),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //doctor Name
                                        const HeadingTextFieldWidget(
                                          text: "Doctor Name",
                                        ),

                                        TextfieldWidget(
                                          hintText:
                                              'Enter the name eg: Dr Meenakshi',
                                          validator: BValidator.validate,
                                          controller:
                                              value.doctorNameController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),

                                        const Gap(8),

                                        const HeadingTextFieldWidget(
                                          text: "Total time available",
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TimePickerSpinnerPopUp(
                                              cancelTextStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              confirmTextStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                              iconSize: 24,
                                              timeFormat: 'hh:mm a',
                                              use24hFormat: false,
                                              mode:
                                                  CupertinoDatePickerMode.time,
                                              initTime: DateTime.now(),
                                              onChange: (dateTime) {
                                                value.availableTotalTimeSlot1 =
                                                    DateFormat.jm()
                                                        .format(dateTime);
                                                value.totalAvailableTimeSetter(
                                                    '${value.availableTotalTimeSlot1 ?? '"please add start time"'} - ${value.availableTotalTimeSlot2 ?? '"please add end time"'}');
                                              },
                                            ),
                                            Text(
                                              '-',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            TimePickerSpinnerPopUp(
                                              cancelTextStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              confirmTextStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                              iconSize: 24,
                                              timeFormat: 'hh:mm a',
                                              use24hFormat: false,
                                              mode:
                                                  CupertinoDatePickerMode.time,
                                              initTime: DateTime.now(),
                                              onChange: (dateTime) {
                                                value.availableTotalTimeSlot2 =
                                                    DateFormat.jm()
                                                        .format(dateTime);
                                                value.totalAvailableTimeSetter(
                                                    '${value.availableTotalTimeSlot1} - ${value.availableTotalTimeSlot2}');
                                              },
                                            ),
                                          ],
                                        ),
                                        const Gap(8),
                                        if (value.availableTotalTime != null)
                                          Column(
                                            children: [
                                              const Gap(8),
                                              ListTile(
                                                tileColor:
                                                    BColors.mainlightColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                title: Center(
                                                  child: Text(
                                                    value.availableTotalTime ??
                                                        'No time added',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        const Gap(8),
                                        const HeadingTextFieldWidget(
                                          text: "Add available time slots",
                                        ),
                                        const TimeSlotChooserWidget(),
                                        ///////////hereeeeee
                                        const Gap(8),

                                        const HeadingTextFieldWidget(
                                          text: "Doctor Fee",
                                        ),
                                        TextfieldWidget(
                                          keyboardType: TextInputType.number,
                                           textInputAction: TextInputAction.next,
                                          hintText:
                                              'Enter the amount in rupees eg: 250 ',
                                          validator: BValidator.validate,
                                          controller: value.doctorFeeController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                        const Gap(8),

                                        const HeadingTextFieldWidget(
                                          text: "Experience",
                                        ),
                                        TextfieldWidget(
                                          keyboardType: TextInputType.number,
                                          hintText:
                                              'Enter the years of experience eg: 5',
                                          validator: BValidator.validate,
                                          controller:
                                              value.experienceController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                        const Gap(8),

                                        const HeadingTextFieldWidget(
                                          text: "Specialization",
                                        ),
                                        TextfieldWidget(
                                          readOnly: true,
                                          hintText:
                                              'Enter the area of specialization',
                                          validator: BValidator.validate,
                                          controller:
                                              value.specializationController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),

                                        const Gap(8),

                                        const HeadingTextFieldWidget(
                                          text: "Qualification",
                                        ),
                                        TextfieldWidget(
                                          textInputAction: TextInputAction.next,
                                          hintText:
                                              'Enter the qualification eg: MBBS,FRCS, etc...',
                                          validator: BValidator.validate,
                                          controller:
                                              value.qualificationController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                        const Gap(8),

                                        const HeadingTextFieldWidget(
                                          text: "About doctor",
                                        ),
                                        TextfieldWidget(
                                          textInputAction: TextInputAction.done,
                                          maxlines: 3,
                                          hintText:
                                              'Enter the about the doctor.',
                                          validator: BValidator.validate,
                                          controller: value.aboutController,
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
                                  height: 48,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (value.imageFile == null) {
                                        CustomToast.errorToast(
                                            text: "Pick doctor's image");
                                        return;
                                      }
                                      if (!formKey.currentState!.validate()) {
                                        formKey.currentState!.validate();
                                        return;
                                      }
                                      if (value.timeSlotListElementList!
                                              .isEmpty ||
                                          value.availableTotalTime == null) {
                                        CustomToast.errorToast(
                                            text:
                                                'No available time slot is added');
                                        return;
                                      }
                                      LoadingLottie.showLoading(
                                          context: context,
                                          text: 'Adding doctor details...');
                                      await value.saveImage();
                                      await value.addDoctorDetail();

                                      // ignore: use_build_context_synchronously
                                      EasyNavigation.pop(context: context);
                                      // ignore: use_build_context_synchronously
                                      EasyNavigation.pop(context: context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: BColors.darkblue,
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
                                        : Text(
                                            'Save',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class HeadingTextFieldWidget extends StatelessWidget {
  const HeadingTextFieldWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: BColors.black),
      ),
    );
  }
}
