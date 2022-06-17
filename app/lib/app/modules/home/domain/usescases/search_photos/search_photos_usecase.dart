import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class SearchPhotosUsecase {
  Future<Either<Failure, PhotoRequestResult>> call(String query, {String? url});
}
