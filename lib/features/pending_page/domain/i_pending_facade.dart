import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';

abstract class IPendingFacade {
  Future<Either<MainFailure, String>> reDirectToWhatsApp({required String whatsAppLink});
}
