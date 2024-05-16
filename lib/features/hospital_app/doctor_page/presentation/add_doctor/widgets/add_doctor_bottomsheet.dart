
import 'package:flutter/material.dart';
import 'package:healthycart/features/hospital_app/doctor_page/presentation/add_doctor/widgets/doctor_form.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';


class PopUpAddDoctorBottomSheet {
  PopUpAddDoctorBottomSheet._();
  static final PopUpAddDoctorBottomSheet _instance =
      PopUpAddDoctorBottomSheet._();
  static PopUpAddDoctorBottomSheet get instance => _instance;

  void showBottomSheet({
    required BuildContext context,
    required VoidCallback addImageTap,
  }) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: BColors.white,
        showDragHandle: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return   
             DoctorAddForm(addImageTap: addImageTap,);
          
        });
  }
}