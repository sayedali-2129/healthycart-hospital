import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/text_formfield/textformfield.dart';
import 'package:healthycart/core/general/validator.dart';
import 'package:healthycart/features/form_field/application/provider/hospital_form_provider.dart';
import 'package:healthycart/features/pending_page/view/pending_page.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class HospitalFormScreen extends StatelessWidget {
  const HospitalFormScreen(
      {super.key,
      required this.place,
      required this.userId,
      required this.phoneNo});
  final Placemark place;
  final String userId;
  final String phoneNo;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Consumer<HosptialFormProvider>(builder: (context, formProvider, _) {
      formProvider.userId = userId;
      formProvider.placemark = place;
      formProvider.phoneNumber = phoneNo;
      formProvider.phoneNumberController.text = phoneNo;
      return Scaffold(
          backgroundColor: const Color(0xFFF5F3F3),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(24),
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Image.asset(
                          BImage.uploadImage,
                          height: 40,
                        ),
                      ),
                    ),
                    const Gap(24),

                    //School Name
                    const Text(
                      "Hospital Name",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: BColors.black),
                    ),
                    const Gap(8),
                    TextfieldWidget(
                      validator: BValidator.validate,
                      controller: formProvider.hospitalNameController, style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16,),
                    ),

                    const Gap(8),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: BColors.black),
                    ),
                    const Gap(8),
                    TextfieldWidget(
                        validator: BValidator.validate,
                        controller: formProvider.phoneNumberController, style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16,),),
                    const Gap(8),
                    const Text(
                      "Owner Name",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: BColors.black),
                    ),
                    const Gap(8),
                    TextfieldWidget(
                      validator: BValidator.validate,
                      controller: formProvider.ownerNameController, style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16,),
                    ),
                    const Gap(8),
                    const Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: BColors.black),
                    ),
                    const Gap(8),
                    TextfieldWidget(
                      validator: BValidator.validate,
                      controller: formProvider.addressController,
                      maxlines: 3, style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16,),
                    ),
                    const Gap(16),
                    SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: BColors.buttonLightColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Upload License',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            fontSize: 16,
                                            color: BColors.white)),
                                const Icon(
                                  Icons.upload_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ],
                            ))),
                    const Gap(24),
                    CustomButton(
                        width: double.infinity,
                        height: 48,
                        onTap: () {
                          if (!formKey.currentState!.validate()) {
                            formKey.currentState!.validate();
                            return;
                          }
                          LoadingLottie.showLoading(
                              context: context, text: 'Loading..');
                          formProvider.addHospitalForm();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PendingPageScreen()));
                        },
                        text: 'Send for review',
                        buttonColor: BColors.buttonDarkColor,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontSize: 18, color: BColors.white))
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
