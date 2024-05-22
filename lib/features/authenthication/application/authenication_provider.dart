import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/toast/toast.dart';

import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/authenthication/presentation/otp_ui.dart';
import 'package:healthycart/features/home/presentation/home.dart';
import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';
import 'package:healthycart/features/add_hospital_form/presentation/hospital_form.dart';
import 'package:healthycart/features/location_page/presentation/location.dart';
import 'package:healthycart/features/pending_page/presentation/pending_page.dart';
import 'package:healthycart/features/splash_screen/splash_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

@injectable
class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider(this.iAuthFacade);
  final IAuthFacade iAuthFacade;
  HospitalModel? hospitalDataFetched;
  String? verificationId;
  String? smsCode;
  final TextEditingController phoneNumberController = TextEditingController();
  String? countryCode;
  String? phoneNumber;
  String? userId;
  bool? isRequsetedPendingPage;

  void setNumber() {
    phoneNumber = '$countryCode${phoneNumberController.text.trim()}';
    log("Phone Number:::: $phoneNumber");
    notifyListeners();
  }

  void hospitalStreamFetchData(
      {required String userId, required BuildContext context}) {
    iAuthFacade.hospitalStreamFetchData(userId).listen((event) {
      event.fold((failure) {
        log("Error IN USER SNAPSHOT  $failure");
      }, (snapshot) {
        hospitalDataFetched = snapshot;
        isRequsetedPendingPage = snapshot.requested;
        notifyListeners();
        if (snapshot.address == null ||
            snapshot.image == null ||
            snapshot.ownerName == null ||
            snapshot.uploadLicense == null) {
          EasyNavigation.pushReplacement(
            type: PageTransitionType.bottomToTop,
            context: context,
            page:
                HospitalFormScreen(phoneNo: hospitalDataFetched?.phoneNo ?? ''),
          );
          notifyListeners();
        } else if (snapshot.placemark == null && snapshot.requested == null) {
          EasyNavigation.pushReplacement(
            type: PageTransitionType.bottomToTop,
            context: context,
            page: const LocationPage(),
          );
          notifyListeners();
        } else if (snapshot.requested == false || snapshot.requested == null) {
          EasyNavigation.pushReplacement(
              type: PageTransitionType.bottomToTop,
              context: context,
              page: const PendingPageScreen());
          notifyListeners();
        } else {
          EasyNavigation.pushReplacement(
              type: PageTransitionType.bottomToTop,
              context: context,
              page: const HomeScreen());
          notifyListeners();
        }
      });
    });
  }

  void verifyPhoneNumber({required BuildContext context}) {
    iAuthFacade.verifyPhoneNumber(phoneNumber!).listen((result) {
      result.fold((failure) {
        Navigator.pop(context);
        CustomToast.errorToast(text: failure.errMsg);
      }, (isVerified) {
        log('VerificationId :::::$isVerified');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => OTPScreen(
                      verificationId: verificationId ?? 'No veriId',
                      phoneNumber: phoneNumber ?? 'No Number',
                    ))));
      });
    });
  }

  Future<void> verifySmsCode(
      {required String smsCode, required BuildContext context}) async {
    final result = await iAuthFacade.verifySmsCode(smsCode: smsCode);
    result.fold((failure) {
      Navigator.pop(context);
      CustomToast.errorToast(text: failure.errMsg);
    }, (userId) {
      userId = userId;
      log('UserId :::::$userId');
      Navigator.pop(context);
      EasyNavigation.pushReplacement(
          context: context,
          page: const SplashScreen());
    });
  }

  Future<void> hospitalLogOut({required BuildContext context}) async {
    final result = await iAuthFacade.hospitalLogOut();
    result.fold((failure) {
      Navigator.pop(context);
      CustomToast.errorToast(text: failure.errMsg);
    }, (sucess) {
      Navigator.pop(context);
      CustomToast.sucessToast(text: sucess);
      EasyNavigation.pushReplacement(
          context: context,
          page: const SplashScreen());
    });
  }
}
