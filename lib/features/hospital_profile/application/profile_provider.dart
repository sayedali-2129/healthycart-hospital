import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/hospital_doctor/domain/model/add_doctor_model.dart';
import 'package:healthycart/features/hospital_profile/domain/i_profile_facade.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this.iProfileFacade);
  final IProfileFacade iProfileFacade;
  final hospitalId = FirebaseAuth.instance.currentUser?.uid;
  List<DoctorAddModel> doctorTotalList = [];
  bool ishospitalON = false;

  void hospitalStatus(bool status) {
    ishospitalON = status;
    notifyListeners();
  }

  Future<void> getAllDoctorDetails() async {
    final result = await iProfileFacade.getAllDoctorDetails();
    result.fold((failure) {
      CustomToast.errorToast(text: "Couldn't able to get all doctor details");
    }, (doctorData) {
      doctorTotalList = doctorData;
    });
  }

  Future<void> setActiveHospital() async {
    final result = await iProfileFacade.setActiveHospital(
        ishospitalON: ishospitalON, hospitalId: hospitalId ?? '');
    result.fold((failure) {
      CustomToast.errorToast(text: "Couldn't able to update hospital state");
    }, (sucess) {
      CustomToast.sucessToast(text: sucess);
    });
    notifyListeners();
  }
}
