import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/services/get_network_time.dart';
import 'package:healthycart/core/services/sent_fcm_message.dart';
import 'package:healthycart/features/hospital_request_userside/domain/i_booking_facade.dart';
import 'package:healthycart/features/hospital_request_userside/domain/models/booking_model.dart';
import 'package:healthycart/features/hospital_request_userside/domain/models/day_transaction_model.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class HospitalBookingProvider extends ChangeNotifier {
  HospitalBookingProvider(this.iBookingFacade);
  final IBookingFacade iBookingFacade;
  bool isLoading = false;

  TextEditingController dateController = TextEditingController();
  String? selectedTimeSlot1;
  String? selectedTimeSlot2;
  String? totalTime;

  void clearTimeSlotData() {
    selectedTimeSlot1 = null;
    selectedTimeSlot2 = null;
    dateController.clear();
    notifyListeners();
  }

  /* ------------------------- GET NEW REQUEST STREAM ------------------------- */
  List<HospitalBookingModel> newRequestList = [];
  void getNewRequestStream({required String hospitalId}) {
    isLoading = true;
    notifyListeners();
    iBookingFacade.getNewRequestStream(hospitalId: hospitalId).listen(
      (event) {
        event.fold(
          (err) {
            CustomToast.errorToast(text: 'Unable to get new orders');
            log('ERROR :: ${err.errMsg}');
            isLoading = false;
            notifyListeners();
          },
          (success) {
            newRequestList = success;
            isLoading = false;
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

  /* ------------------------- GET ACCEPTED REQUEST STREAM ------------------------- */
  List<HospitalBookingModel> acceptedList = [];
  void getAcceptedBookingsStream({required String hospitalId}) {
    isLoading = true;
    notifyListeners();
    iBookingFacade.getAcceptedBookingsStream(hospitalId: hospitalId).listen(
      (event) {
        event.fold(
          (err) {
            log('ERROR :: ${err.errMsg}');
            isLoading = false;
            notifyListeners();
          },
          (success) {
            acceptedList = success;
            isLoading = false;
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

  /* ------------------------------ SET TIME SLOT ----------------------------- */
  Future<void> setTimeSlot(
      {required String bookingId,
      required String newDate,
      required String newTime}) async {
    final result = await iBookingFacade.setNewTimeSlot(
        bookingId: bookingId, newDate: newDate, newTimeSlot: newTime);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        CustomToast.sucessToast(text: success);
      },
    );
  }

  /* --------------------------- UPDATE ORDER STATUS -------------------------- */
  TextEditingController rejectionReasonCobtroller = TextEditingController();
  final rejectionFormKey = GlobalKey<FormState>();

  Future<void> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      required String fcmtoken,
      String? hospitalName,
      String? hospitalId,
      num? totalAmount,
      String? dayTransactionDate,
      String? paymentMode,
      String? rejectReason}) async {
    isLoading = true;
    notifyListeners();
    final networkTime = await getNetworkTime();

    final result = await iBookingFacade.updateOrderStatus(
        totalAmount: totalAmount,
        orderId: orderId,
        orderStatus: orderStatus,
        hospitalId: hospitalId,
        rejectReason: rejectReason,
        dayTransactionDate: dayTransactionDate,
        paymentMode: paymentMode,
        dayTransactionModel: DayTransactionModel(
          createdAt: Timestamp.fromDate(networkTime),
          totalAmount: totalAmount,
          offlinePayment: paymentMode != 'Online' ? totalAmount : 0,
          onlinePayment: paymentMode == 'Online' ? totalAmount : 0,
        ));
    result.fold((err) {
      CustomToast.errorToast(text: err.errMsg);
      isLoading = false;
      notifyListeners();
    }, (success) {
      if (orderStatus == 3) {
        sendFcmMessage(
            token: fcmtoken,
            body:
                'Your booking is rejected by $hospitalName hospital, Click to check details!!',
            title: 'Booking Rejected!!');
      } else if (orderStatus == 1) {
        sendFcmMessage(
            token: fcmtoken,
            body:
                'Your booking is approved by $hospitalName hospital, Please check the details and complete payment!!',
            title: 'Booking Approved!!');
      } else if (orderStatus == 2) {
        sendFcmMessage(
            token: fcmtoken,
            body:
                'Your hospital appointment is successfully completed, Thank you for choosing Healthycart. We look forward to continuing to serve your healthcare needs.',
            title: 'Appointment Completed!!');
      }
      CustomToast.sucessToast(text: success);
      isLoading = false;
      notifyListeners();
    });
  }

  /* ------------------------------ LAUNCH DIALER ----------------------------- */
  Future<void> lauchDialer({required String phoneNumber}) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      CustomToast.errorToast(text: 'Could not launch the dialer');
    }
  }

  /* ------------------------- GET COMPLETED BOOKINGS ------------------------- */
  List<HospitalBookingModel> completedList = [];
  Future<void> getCompletedOrders(
      {required String hospitalId, required int limit}) async {
    isLoading = true;
    notifyListeners();
    final result = await iBookingFacade.getCompletedBookings(
        hospitalId: hospitalId, limit: limit);
    result.fold((err) {
      log('error in getCompletedOrders() :: ${err.errMsg}');
    }, (success) {
      completedList.addAll(success);
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }

  void cleatDataCompleted() {
    iBookingFacade.clearDataCompleted();
    completedList = [];
    notifyListeners();
  }

  void completeInit(
      ScrollController scrollController, String hospitalId, int limit) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0 &&
            isLoading == false) {
          getCompletedOrders(hospitalId: hospitalId, limit: limit);
        }
      },
    );
  }
/* -------------------------------------------------------------------------- */

/* -------------------------- GET REJECTED BOOKINGS ------------------------- */
  List<HospitalBookingModel> rejectedBookings = [];
  Future<void> getRejectedOrders({required String hospitalId}) async {
    isLoading = true;
    notifyListeners();
    final result =
        await iBookingFacade.getRejectedOrders(hospitalId: hospitalId);
    result.fold(
      (err) {
        log('Error in getRejectedOrders() :: ${err.errMsg}');
      },
      (success) {
        rejectedBookings.addAll(success);
        notifyListeners();
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void clearDataRejected() {
    iBookingFacade.clearDataRejected();

    rejectedBookings = [];
    notifyListeners();
  }

  void rejectInit(ScrollController scrollController, String hospitalId) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0 &&
            isLoading == false) {
          getRejectedOrders(hospitalId: hospitalId);
        }
      },
    );
  }

  /* --------------- UPDATE PAYMENT STATUS WHEN PAYMENT RECEIVED -------------- */

  Future<void> updatePaymentStatus({required String orderId}) async {
    final result = await iBookingFacade.updatePaymentStatus(orderId: orderId);
    result.fold((err) {
      CustomToast.errorToast(text: 'Order status update failed');
      log('ERROR updatePaymentStatus :: ${err.errMsg}');
    }, (success) {
      CustomToast.sucessToast(text: success);
    });
    notifyListeners();
  }
}
