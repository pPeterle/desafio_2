import 'package:app/app/modules/home/domain/entities/request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/infra/datasource/photo_remote_datasource.dart';
import 'package:app/app/modules/home/infra/models/photo_request_result_model.dart';
import 'package:app/app/modules/home/infra/repositories/photo_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PhotoRemoteDasoureMock extends Mock implements PhotoRemoteDatasource {}

void main() {
  final remoteDatasource = PhotoRemoteDasoureMock();
  final repository = PhotoRepositoryImpl(remoteDatasource);

  test('should return photo request result on success in getPhotos', () async {
    when(() => remoteDatasource.searchPhotos(any())).thenAnswer(
      (_) async => PhotoRequestResultModel(
        totalResults: 1,
        page: 1,
        perPage: 1,
        photos: [],
      ),
    );
    final result = await repository.searchPhotos('');

    expect(
      result.getOrElse(() => fail('should return right')),
      isA<RequestResult>(),
    );
  });

  test('should return DataSourceError on error in getPhotos', () async {
    when(() => remoteDatasource.searchPhotos(any())).thenThrow(Error());
    final result = await repository.searchPhotos('');

    expect(
      result.fold(id, id),
      isA<DataSourceError>(),
    );
  });
}
