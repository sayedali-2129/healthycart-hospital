import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/blocked_alert_box.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/add_hospital_form_page/domain/model/hospital_model.dart';
import 'package:healthycart/features/add_hospital_form_page/presentation/hospital_form.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/authenthication/presentation/otp_ui.dart';
import 'package:healthycart/features/home/presentation/home.dart';
import 'package:healthycart/features/location_picker/presentation/location.dart';
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
  int? isRequsetedPendingPage;

  bool showUserBlockDilogue = false;

  void setShowUserBlock(bool value) {
    showUserBlockDilogue = value;
    if (showUserBlockDilogue) {
      UserBlockedAlertBox.userBlockedAlert();
    }
    showUserBlockDilogue = true;
    notifyListeners();
  }

  void setNumber() {
    phoneNumber = '$countryCode${phoneNumberController.text.trim()}';
    notifyListeners();
  }

  bool hospitalStreamFetchData({required String userId}) {
    bool result = false;
    iAuthFacade.hospitalStreamFetchData(userId).listen((event) {
      event.fold((failure) {
        result = false;
      }, (snapshot) {
        hospitalDataFetched = snapshot;
        isRequsetedPendingPage = snapshot.requested;
        result = true;
        notifyListeners();
        if (snapshot.isActive == false) {
          UserBlockedAlertBox.userBlockedAlert();
        } else {}
      });
    });
    return result;
  }

  void navigationHospitalFuction({required BuildContext context}) async {
    if (hospitalDataFetched?.address == null ||
        hospitalDataFetched?.image == null ||
        hospitalDataFetched?.ownerName == null ||
        hospitalDataFetched?.uploadLicense == null ||
        hospitalDataFetched?.hospitalName == null ||
        hospitalDataFetched?.email == null) {
      EasyNavigation.pushReplacement(
        type: PageTransitionType.bottomToTop,
        context: context,
        page: HospitalFormScreen(
          hospitalModel: hospitalDataFetched,
          isEditing: false,
        ),
      );
      notifyListeners();
    } else if (hospitalDataFetched?.placemark == null) {
      EasyNavigation.pushReplacement(
        type: PageTransitionType.bottomToTop,
        context: context,
        page: const LocationPage(),
      );
      notifyListeners();
    } else if ((hospitalDataFetched?.requested == 0 ||
            hospitalDataFetched?.requested == 1) &&
        hospitalDataFetched?.placemark != null) {
      EasyNavigation.pushReplacement(
          type: PageTransitionType.bottomToTop,
          context: context,
          page: const PendingPageScreen());
      notifyListeners();
    } else {
      EasyNavigation.pushAndRemoveUntil(
          type: PageTransitionType.bottomToTop,
          context: context,
          page: const HomeScreen());
      notifyListeners();
    }
  }

  void verifyPhoneNumber({required BuildContext context}) {
    iAuthFacade.verifyPhoneNumber(phoneNumber!).listen((result) {
      result.fold((failure) {
        Navigator.pop(context);
        CustomToast.errorToast(text: failure.errMsg);
      }, (isVerified) {
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
      Navigator.pop(context);
      EasyNavigation.pushReplacement(
          context: context, page: const SplashScreen());
      phoneNumberController.clear();
    });
  }

  Future<void> hospitalLogOut({required BuildContext context}) async {
    final result = await iAuthFacade.hospitalLogOut();
    result.fold((failure) {
      EasyNavigation.pop(context: context);
      CustomToast.errorToast(text: failure.errMsg);
    }, (sucess) {
      EasyNavigation.pop(context: context);
      CustomToast.sucessToast(text: sucess);
      EasyNavigation.pushReplacement(
          context: context, page: const SplashScreen());
    });
  }
}
