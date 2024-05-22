import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/button/common_button.dart';
import 'package:healthycart/core/custom/divider/divider.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/custom/text_formfield/textformfield.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/general/validator.dart';
import 'package:healthycart/features/add_hospital_form/application/hospital_form_provider.dart';
import 'package:healthycart/features/location_page/presentation/location.dart';
import 'package:healthycart/features/pending_page/presentation/pending_page.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class HospitalFormScreen extends StatelessWidget {
  const HospitalFormScreen({super.key, required this.phoneNo});

  final String phoneNo;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Consumer<HosptialFormProvider>(builder: (context, formProvider, _) {
      //  formProvider.placemark = place;
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
                      child: GestureDetector(
                          onTap: () {
                            formProvider
                                .getImage()
                                .then((value) => value.fold((failure) {
                                      CustomToast.errorToast(
                                          text: failure.errMsg);
                                    }, (imageFile) {
                                      formProvider.imageFile = imageFile;
                                    }));
                          },
                          child: (formProvider.imageFile == null)
                              ? Center(
                                  child: Image.asset(
                                    BImage.uploadImage,
                                    height: 40,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.file(
                                      formProvider.imageFile!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                    ),
                    const Gap(16),
                    const DividerWidget(text: 'Tap above to add image'),
                    const Gap(24),

                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BColors.black),
                      ),
                    ),
                    TextfieldWidget(
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: BValidator.validate,
                      controller: formProvider.phoneNumberController,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    const Gap(8),
                    //hospital Name
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Hospital Name",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BColors.black),
                      ),
                    ),

                    TextfieldWidget(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      minlines: 1,
                      maxlines: 2,
                      validator: BValidator.validate,
                      controller: formProvider.hospitalNameController,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    const Gap(8),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Proprietor Name",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BColors.black),
                      ),
                    ),

                    TextfieldWidget(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: BValidator.validate,
                      controller: formProvider.ownerNameController,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    const Gap(8),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Hospital Address",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BColors.black),
                      ),
                    ),

                    TextfieldWidget(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      validator: BValidator.validate,
                      controller: formProvider.addressController,
                      maxlines: 3,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    const Gap(16),
                    SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () async {
                              await formProvider
                                  .getPDF()
                                  .then((value) => value.fold((failure) {
                                        CustomToast.errorToast(
                                            text: failure.errMsg);
                                      }, (pdfFile) {
                                        formProvider.pdfFile = pdfFile;
                                      }));
                            },
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
                    const Gap(16),
                    (formProvider.pdfFile != null)
                        ? Center(
                          child: Container(
                              height: 64,
                              width: 56,
                              color: BColors.lightGrey,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: Image.asset(BImage.imagePDF)),
                                  Positioned(
                                      top: -9,
                                      right: -9,
                                      child: IconButton(
                                          onPressed: () {
                                            formProvider.clearPdf();
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 24,
                                            color: Colors.red,
                                          ))),
                                ],
                              ),
                            ),
                        )
                        : const DividerWidget(text: 'Upload document as PDF'),
                    const Gap(24),
                    CustomButton(
                        width: double.infinity,
                        height: 48,
                        onTap: () async {
                          if (formProvider.imageFile == null) {
                            CustomToast.errorToast(text: 'Pick an image');
                            return;
                          }
                          if (!formKey.currentState!.validate()) {
                            formKey.currentState!.validate();
                            return;
                          }
                          // if (formProvider.pdfFile == null) {
                          //   CustomToast.errorToast(
                          //       text: 'Pick hospital liscense document');
                          //   return;
                          // }
                          LoadingLottie.showLoading(
                              context: context, text: 'Loading...');

                          await formProvider.saveImage().then((value) {
                            value.fold((failure) {
                              return CustomToast.errorToast(
                                  text: failure.errMsg);
                            }, (imageUrl) async{
                              formProvider.imageUrl = imageUrl;
                              await formProvider.addHospitalForm(context: context);
                            });
                          });
                          // await formProvider.savePDF().then((value) {
                          //   value.fold((failure) {
                          //     return CustomToast.errorToast(
                          //         text: failure.errMsg);
                          //   }, (pdfUrl) {
                          //     formProvider.pdfUrl = pdfUrl;
                          //   });
                          // });
                          
                    
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
