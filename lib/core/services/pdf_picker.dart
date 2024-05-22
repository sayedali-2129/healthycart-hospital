import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PdfPickerService {
  PdfPickerService(this._storage);
  final FirebaseStorage _storage;

  
  FutureResult<File> getPdfFile() async {
    final FilePickerResult? pickedFile;

    try {
      pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      log(pickedFile.toString());
      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        PlatformFile file = pickedFile.files.first;
        File pdfFile = File(file.path!);
        return right(pdfFile);
      } else {
        return left(const MainFailure.generalException(
            errMsg: "Couldn't able to pick PDF file"));
      }
    } catch (e) {
      return left(const MainFailure.generalException(
          errMsg: "Couldn't able to pick PDF file"));
    }
  }

  FutureResult<String?> uploadPdf({
    required File pdfFile,
  }) async {
    final String pdfName =
        'hospital_pdf/${DateTime.now().microsecondsSinceEpoch}.pdf';
    final String? downloadPdfUrl;
    try {
      await _storage
          .ref(pdfName)
          .putFile(pdfFile, SettableMetadata(contentType: 'file/pdf'));
      downloadPdfUrl = await _storage.ref(pdfName).getDownloadURL();
      return  right(downloadPdfUrl);
    } catch (e) {
      return left(const MainFailure.generalException(
          errMsg: "Couldn't able to save PDF file"));
    }

  }

  Future<void> deletePdfUrl({
    required String? url,
  }) async {
    if (url == null) return;
    final pdfRef = _storage.refFromURL(url);
    try {
      await pdfRef.delete();
    } catch (e) {

    }
  }
}
