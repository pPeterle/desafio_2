import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:app/app/modules/home/infra/datasource/photo_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/photo_request_result.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDatasource _remoteDatasource;

  PhotoRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, PhotoRequestResult>> searchPhotos(
    String query, {
    int page = 1,
  }) async {
    try {
      final result = await _remoteDatasource.searchPhotos(
        query,
        page: page,
      );
      return Right(result.mapToDomain());
    } on InternetConnectionError {
      return Left(InternetConnectionError());
    } on InvalidQueryError {
      return Left(InvalidQueryError());
    } catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, PhotoRequestResult>> getCuratedPhotos({
    int page = 1,
  }) async {
    try {
      final result = await _remoteDatasource.getCuratedPhotos(
        page: page,
      );
      return Right(result.mapToDomain());
    } on InternetConnectionError {
      return Left(InternetConnectionError());
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
