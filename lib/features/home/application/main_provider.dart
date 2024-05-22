import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';
import 'package:healthycart/features/home/domain/i_main_facade.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainProvider extends ChangeNotifier {
  MainProvider(this._iMainFacade);
  final IMainFacade _iMainFacade;
  HospitalModel? hospitalDetails;
  String? userId;
  Future<void> getHospitalDetails() async {
    log('Main page getting userId $userId');
    if (hospitalDetails != null) return;
    final result = await _iMainFacade.getHospitalDetails(userId: userId!);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Couldn't able to get user");
    }, (hospitaldetails) {
      hospitalDetails = hospitaldetails;
      log(hospitaldetails.address.toString());
      notifyListeners();
    });
  }
}
