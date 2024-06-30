import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/hospital_request_userside/domain/models/booking_model.dart';

abstract class IBookingFacade {
  Stream<Either<MainFailure, List<HospitalBookingModel>>> getNewRequestStream(
      {required String hospitalId});
  FutureResult<String> setNewTimeSlot(
      {required String bookingId,
      required String newDate,
      required String newTimeSlot});
  FutureResult<String> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      String? hospitalId,
      String? rejectReason,
      num? totalAmount});

  Stream<Either<MainFailure, List<HospitalBookingModel>>>
      getAcceptedBookingsStream({
    required String hospitalId,
  });
  FutureResult<List<HospitalBookingModel>> getCompletedBookings(
      {required String hospitalId, required int limit});
  void clearDataCompleted();
  FutureResult<List<HospitalBookingModel>> getRejectedOrders(
      {required String hospitalId});
  void clearDataRejected();
}
