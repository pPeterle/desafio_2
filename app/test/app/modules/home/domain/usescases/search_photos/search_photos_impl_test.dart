import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PhotoRepositoryMock extends Mock implements PhotoRepository {}

void main() {
  final PhotoRepositoryMock repository = PhotoRepositoryMock();
  final SearchPhotosImpl usecase = SearchPhotosImpl(repository);
  test('should return PhotoRequestResult on success', () async {
    when(() => repository.searchPhotos(any())).thenAnswer(
      (_) async => Right(
        PhotoRequestResult(photos: [], page: 1, perPage: 1, totalResults: 1),
      ),
    );
    final result = await usecase('query');

    expect(
      result.getOrElse(() => fail('should return right')),
      isA<PhotoRequestResult>(),
    );
  });

  test('should return Failure on error', () async {
    when(() => repository.searchPhotos(any())).thenAnswer(
      (_) async => Left(DataSourceError()),
    );
    final result = await usecase('query');

    expect(
      result.fold(id, id),
      isA<Failure>(),
    );
  });

  test('should return InvalidTextError if url is incorrect', () async {
    when(() => repository.searchPhotos(any())).thenAnswer(
      (_) async => Right(
        PhotoRequestResult(photos: [], page: 1, perPage: 1, totalResults: 1),
      ),
    );
    final result = await usecase('query', url: 'incorrect');

    expect(
      result.fold(id, id),
      isA<InvalidUrlError>(),
    );
  });

  test('should call repository with the correct page', () async {
    when(() => repository.searchPhotos(any(), page: 5)).thenAnswer(
      (_) async => Right(
        PhotoRequestResult(photos: [], page: 5, perPage: 1, totalResults: 1),
      ),
    );
    final result = await usecase('query', url: 'correct&page=5');

    expect(
      result.getOrElse(() => fail('should return right')),
      isA<PhotoRequestResult>(),
    );
    expect(
      result.getOrElse(() => throw Error()).page,
      equals(5),
    );
  });
}
