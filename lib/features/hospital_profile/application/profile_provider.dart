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
  bool ishospitalON = false;

  void hospitalStatus(bool status) {
    ishospitalON = status;
    notifyListeners();
  }

 /* ----------------------------- GET ALL DOCTORS ---------------------------- */
   final TextEditingController searchController = TextEditingController();
  List<DoctorAddModel> allDoctorList = [];
  bool fetchLoading = false;
 
  Future<void> getHospitalAllDoctorDetails({String? searchText}) async {
    fetchLoading = true;
    notifyListeners();
    final result = await iProfileFacade.getHospitalAllDoctorDetails(
        hospitalId: hospitalId ??'', searchText: searchText);
    result.fold((failure) {
      CustomToast.errorToast(text: "Couldn't able to show doctors");
    }, (products) {
      allDoctorList.addAll(products); //// here we are assigning the doctor
    });
    fetchLoading = false;
    notifyListeners();
  }

  void clearFetchData() {
    searchController.clear();
    allDoctorList.clear();
    iProfileFacade.clearFetchData();
  }

  void searchDoctors(String searchText) {
    allDoctorList.clear();
    iProfileFacade.clearFetchData();
    getHospitalAllDoctorDetails(searchText: searchText);
    notifyListeners();
  }
  /* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
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
