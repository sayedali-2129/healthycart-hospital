import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/firebase_collection.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/core/services/image_picker.dart';
import 'package:healthycart/core/services/pdf_picker.dart';
import 'package:healthycart/features/add_hospital_form_page/domain/i_form_facade.dart';
import 'package:healthycart/features/add_hospital_form_page/domain/model/hospital_model.dart';
import 'package:injectable/injectable.dart';



@LazySingleton(as: IFormFeildFacade)
class IFormFieldImpl implements IFormFeildFacade {
  IFormFieldImpl(this._repo, this._imageService, this._pdfService);
  final FirebaseFirestore _repo;
  final ImageService _imageService;
  final PdfPickerService _pdfService;
  @override
  /////////////adding hospital to the collection
  FutureResult<String> addHospitalDetails(
      {required HospitalModel hospitalDetails, required String hospitalId,}) async {
    try {
      await _repo
          .collection(FirebaseCollections.hospitals)
          .doc(hospitalId)
          .update(hospitalDetails.toMap());
      return right('Sucessfully sent for review');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    }catch(e){
       return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<HospitalModel> getHospitalDetails(
      {required String userId,}) async {
    try {
      final snapshot = await _repo
          .collection(FirebaseCollections.hospitals)
          .doc(userId)
          .get();
      return right(HospitalModel.fromMap(snapshot.data()!));
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
//Image section -------------------------------------
  @override
  FutureResult<File> getImage() async {
    return await _imageService.getGalleryImage();
  }

  @override
  Future<Either<MainFailure, String>> saveImage(
      {required File imageFile}) async {
    return await _imageService.saveImage(imageFile: imageFile);
  }

   @override
  Future<Either<MainFailure, Unit>> deleteImage(
      {required String imageUrl}) async {
    return await _imageService.deleteImageUrl(imageUrl: imageUrl);
  }
///////////////////////////////////////////////////////////////////////////


  @override
  FutureResult<File> getPDF() async {
    return await _pdfService.getPdfFile();
  }

  @override
  FutureResult<String?> savePDF({required File pdfFile,}) async {
    return await _pdfService.uploadPdf(pdfFile: pdfFile);
  }
  
  @override
  FutureResult<String?> deletePDF({required String pdfUrl,}) async{
   return await _pdfService.deletePdfUrl(url: pdfUrl);
  }
  ///update section from profile--------------------
  @override
   FutureResult<String> updateHospitalForm({required HospitalModel hospitalDetails, required String hospitalId,}) async{
      try {
      await _repo
          .collection(FirebaseCollections.hospitals)
          .doc(hospitalId)
          .update(hospitalDetails.toEditMap());
      return right('Sucessfully sent for review');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
