import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class PhotoRepository {
  Future<Either<Failure, PhotoRequestResult>> getPhotosNextPage(String url);
  Future<Either<Failure, PhotoRequestResult>> getPhotos({String? query});
}
