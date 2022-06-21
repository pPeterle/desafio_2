import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class PhotoRepository {
  Future<Either<Failure, PhotoRequestResult>> searchPhotos(
    String query, {
    int page = 1,
  });

  Future<Either<Failure, PhotoRequestResult>> getCuratedPhotos({
    int page = 1,
  });
}
