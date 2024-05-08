import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/features/form_field/domain/i_form_facade.dart';
import 'package:healthycart/features/form_field/domain/model/hospital_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HosptialFormProvider extends ChangeNotifier {
  HosptialFormProvider(this.iFormFeildFacade);
  final IFormFeildFacade iFormFeildFacade;

  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();

  HospitalModel? hospitalDetail;
  String? userId;
  String? phoneNumber;
  Placemark? placemark;

  Future<void> addHospitalForm() async {
    hospitalDetail = HospitalModel().copyWith(
        phoneNo: phoneNumber,
        hospitalName: hospitalNameController.text,
        address: addressController.text,
        placemark: placemark,
        ownerName: ownerNameController.text,
        uploadLicense: '',
        image: '');

    iFormFeildFacade.addHospitalDetails(
        hospitalDetails: hospitalDetail!, userId: userId!);
  }
}
