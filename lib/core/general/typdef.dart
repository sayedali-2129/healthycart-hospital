import 'package:dartz/dartz.dart';
import 'package:healthycart/core/failures/main_failure.dart';

typedef FutureResult<T> = Future<Either<MainFailure, T>>;
