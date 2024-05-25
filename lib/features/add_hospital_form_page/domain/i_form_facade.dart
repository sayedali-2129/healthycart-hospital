import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/add_hospital_form_page/domain/model/hospital_model.dart';

abstract class IFormFeildFacade {
  FutureResult<String>  addHospitalDetails({
    required HospitalModel hospitalDetails,
    required String hospitalId,
  });
  FutureResult<HospitalModel>  getHospitalDetails({
    required String userId,
  });
  FutureResult<File> getImage();
  FutureResult<String> saveImage({
    required File imageFile,
  });
  FutureResult<Unit>  deleteImage({
    required String imageUrl,
  });
  FutureResult<String>  updateHospitalForm({
    required HospitalModel hospitalDetails,
    required String hospitalId,
  });
  FutureResult<File> getPDF();
  FutureResult<String?> savePDF({
    required File pdfFile,
  });
  FutureResult<String?> deletePDF({
    required String pdfUrl,
  });
}
