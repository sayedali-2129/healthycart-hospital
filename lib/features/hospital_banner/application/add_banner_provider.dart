import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/hospital_banner/domain/i_banner_facade.dart';
import 'package:healthycart/features/hospital_banner/domain/model/hospital_banner_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddBannerProvider extends ChangeNotifier {
  AddBannerProvider(this.iBannerFacade);
  final IBannerFacade iBannerFacade;

  String? imageUrl;
  File? imageFile;
  HospitalBannerModel? banner;
  List<HospitalBannerModel> bannerList = [];
  bool fetchLoading = false;

  Future<void> getImage() async {
    final result = await iBannerFacade.getImage();
    notifyListeners();
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Can't able to pick an image.");
    }, (imagefile) {
      imageFile = imagefile;
      notifyListeners();
      CustomToast.sucessToast(text: "Image picked sucessfully.");
    });
  }

  Future<void> saveImage() async {
    if (imageFile == null) {
      CustomToast.errorToast(text: "Pick an image.");
      return;
    }
    final result = await iBannerFacade.saveImage(imageFile: imageFile!);

    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Can't able to save image.");
    }, (imageurl) {
      imageUrl = imageurl;
      notifyListeners();
    });
    return;
  }

  Future<void> addBanner() async {
    banner = HospitalBannerModel(
      isCreated: Timestamp.now(),
      image: imageUrl,
    );
    fetchLoading = true;
    notifyListeners();
    final result = await iBannerFacade.addHospitalBanner(banner: banner!);
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Can't able to save banner");
    }, (model) {
      bannerList.insert(bannerList.length, model);
    });
    fetchLoading = false;
    clearBannerDetails();
    notifyListeners();
    return;
  }

  Future<void> getBanner() async {
    if (bannerList.isNotEmpty) return;
    fetchLoading = true;
    notifyListeners();
    final result = await iBannerFacade.getHospitalBanner();
    result.fold((failure) {
      log(failure.errMsg);
      CustomToast.errorToast(text: "Couldn't able to get banner");
    }, (bannerlist) {
      bannerList.addAll(bannerlist);
      fetchLoading = false;
      notifyListeners();
    });
  }

  void clearBannerDetails() {
    imageFile = null;
    notifyListeners();
    if (imageUrl != null) {
      imageUrl = null;
    }
    notifyListeners();
  }
}
