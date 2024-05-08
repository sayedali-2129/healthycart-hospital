import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/doctor_page/application/provider/doctor_provider.dart';
import 'package:healthycart/features/doctor_page/presentation/add_doctor/add_doctor.dart';
import 'package:healthycart/features/doctor_page/presentation/doctor_category/widgets/add_category_popup_widget.dart';
import 'package:healthycart/features/doctor_page/presentation/doctor_category/widgets/add_new_round_widget.dart';
import 'package:healthycart/features/doctor_page/presentation/doctor_category/widgets/round_text_widget.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    PopUpSingleTextDialog popUp = PopUpSingleTextDialog.instance;
    return Consumer<DoctorProvider>(builder: (context, doctorProvider, _) {
      return CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomCurveAppBarWidget(),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 120),
              itemBuilder: (context, index) {
                if (index == 4) {
                  return AddNewRoundWidget(
                      title: 'Add New',
                      onTap: () {
                        popUp.showSingleTextAddDialog(
                            addButtonImageWidth: 200,
                            context: context,
                            nameTitle: 'Category Name',
                            labelTitle: 'Enter category',
                            titleController: doctorProvider.categoryController,
                            buttonText: 'Save',
                            addTap: () {
                              doctorProvider
                                  .getImage()
                                  .then((value) => value.fold((failure) {
                                        errorToast(text: failure.errMsg);
                                      }, (imageFile) {
                                        doctorProvider.imageFile = imageFile;
                                      }));
                            },
                            buttonTap: () {
                              if (doctorProvider.imageFile == null) {
                                errorToast(text: 'Pick category image');
                                return;
                              }
                              if (!formKey.currentState!.validate()) {
                                formKey.currentState!.validate();
                                return;
                              }

                              doctorProvider
                                  .addCategory()
                                  .then((value) => value.fold(
                                      (l) => errorToast(
                                            text: l.errMsg,
                                          ),
                                      (r) => sucessToast(text: r)));
                            },
                            formKeyValue: formKey);
                      });
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const AddDoctorScreen())));
                    },
                    child: const VerticalImageText(
                        image: BImage.logo, title: 'General Health'),
                  );
                }
              },
            ),
          )
        ],
      );
    });
  }
}
