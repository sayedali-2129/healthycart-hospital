import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ImageService {
  ImageService(this._storage);

  final FirebaseStorage _storage;
  final ImagePicker picker = ImagePicker();
  Future<Either<MainFailure, File>> getGalleryImage() async {
    final XFile? pickedImageFile;
    final File? imageFile;
    try {
      pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImageFile != null) {
        imageFile = File(pickedImageFile.path);
        return right(imageFile);
      } else {
        return left(
            const MainFailure.generalException(errMsg: 'Image is not picked'));
      }
    } catch (e) {
      return left(
          const MainFailure.generalException(errMsg: 'Image is not picked'));
    }
  }

//save image

  Future<Either<MainFailure, String>> saveImage({
    required File imageFile,
  }) async {
    final String imageName =
        'healthycart/${DateTime.now().microsecondsSinceEpoch}.png';
    final String? downloadUrl;
    try {
      await _storage
          .ref(imageName)
          .putFile(imageFile, SettableMetadata(contentType: 'image/png'));
      downloadUrl = await _storage.ref(imageName).getDownloadURL();

      return right(downloadUrl);
    } catch (e) {
      return left(
          const MainFailure.generalException(errMsg: 'Image is not picked'));
    }
  }

//delete Image

//  Future<Either<MainFailure, void >> deleteUrl({
//     required String? imageUrl,
//   }) async {
//     if (imageUrl == null) return right(none());
//     final imageRef = _storage.refFromURL(imageUrl);
//     try {
//       await imageRef.delete();

//     } catch (e) {
//       onFailure.call(BText.imageDeleteError);
//     }
//   }
}
