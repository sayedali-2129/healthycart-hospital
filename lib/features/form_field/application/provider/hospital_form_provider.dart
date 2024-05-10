import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/features/form_field/domain/i_form_facade.dart';
import 'package:healthycart/features/form_field/domain/model/hospital_model.dart';
import 'package:healthycart/utils/constants/enums.dart';
import 'package:injectable/injectable.dart';

@injectable
class HosptialFormProvider extends ChangeNotifier {
  HosptialFormProvider(this.iFormFeildFacade);
  final IFormFeildFacade iFormFeildFacade;

//Image section
  String? imageUrl;
  File? imageFile;
  bool fetchLoading = false;

  Future<Either<MainFailure, File>> getImage() async {
    final result = await iFormFeildFacade.getImage();
    notifyListeners();
    return result;
  }

  Future<Either<MainFailure, String>> saveImage() async {
    if (imageFile == null) {
      return left(const MainFailure.generalException(
          errMsg: 'Please chek the image selected.'));
    }
    final result = await iFormFeildFacade.saveImage(imageFile: imageFile!);
    return result;
  }

  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();

  HospitalModel? hospitalDetail;
  String? userId;

  Placemark? placemark;
  AdminType? adminType;
  Future<Either<MainFailure, String>> addHospitalForm() async {
    hospitalDetail = HospitalModel().copyWith(
        phoneNo: phoneNumberController.text,
        hospitalName: hospitalNameController.text,
        address: addressController.text,
        placemark: placemark,
        ownerName: ownerNameController.text,
        uploadLicense: '',
        image: imageUrl,
        adminType: adminType);

    final result = await iFormFeildFacade.addHospitalDetails(
        hospitalDetails: hospitalDetail!, userId: userId!);
    clearAllData();
    notifyListeners();
    return result;
  }

  void clearAllData() {
    hospitalNameController.clear();
    addressController.clear();
    adminType = null;
    phoneNumberController.clear();
    ownerNameController.clear();
    notifyListeners();
  }
}
