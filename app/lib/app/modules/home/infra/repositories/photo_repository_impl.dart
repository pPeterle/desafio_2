import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:app/app/modules/home/infra/datasource/photo_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/photo_request_result.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDatasource _remoteDatasource;

  PhotoRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, PhotoRequestResult>> getPhotos({
    String? query,
  }) async {
    try {
      final result = await _remoteDatasource.getPhotos(query: query);
      return Right(result.mapToDomain());
    } catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, PhotoRequestResult>> getPhotosNextPage(
    String url,
  ) async {
    try {
      final result = await _remoteDatasource.getPhotosNextPage(url);
      return Right(result.mapToDomain());
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
