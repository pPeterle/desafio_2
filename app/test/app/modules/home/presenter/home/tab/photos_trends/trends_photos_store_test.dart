import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/state/tab_state.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_curated/curated_photos_store.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_trends/trends_photos_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:triple_test/triple_test.dart';

class SearchPhotosUsecaseMock extends Mock implements SearchPhotosUsecase {}

class MockCounterStore extends MockStore<Failure, TabState>
    implements CuratedPhotosStore {}

const query = 'Trends';
void main() {
  late SearchPhotosUsecaseMock usecaseMock;

  setUp(() {
    usecaseMock = SearchPhotosUsecaseMock();
  });
  storeTest<TrendsPhotosStore>(
    'should fetch data',
    build: () {
      when(() => usecaseMock(query)).thenAnswer(
        (invocation) async => Right(
          PhotoRequestResult(
            page: 1,
            perPage: 1,
            photos: [],
            totalResults: 1,
            nextPage: '',
          ),
        ),
      );
      return TrendsPhotosStore(usecaseMock);
    },
    act: (store) => store.fetchData(),
    expect: () => [true, TabFetchData(photos: [], nextpage: ''), false],
  );

  storeTest<TrendsPhotosStore>(
    'should fetch new page',
    build: () {
      when(() => usecaseMock(query)).thenAnswer(
        (invocation) async => Right(
          PhotoRequestResult(
            page: 1,
            perPage: 1,
            photos: [],
            totalResults: 1,
            nextPage: 'url',
          ),
        ),
      );
      when(() => usecaseMock(query, url: 'url')).thenAnswer(
        (invocation) async => Right(
          PhotoRequestResult(
            page: 1,
            perPage: 1,
            photos: [],
            totalResults: 1,
            nextPage: 'url',
          ),
        ),
      );
      return TrendsPhotosStore(usecaseMock);
    },
    act: (store) async {
      await store.fetchData();
      await store.fetchNewPage();
    },
    expect: () => [
      true,
      TabFetchData(photos: [], nextpage: ''),
      false,
      TabFetchData(photos: [], nextpage: '', loadingNewPage: true),
      TabFetchData(photos: [], nextpage: '', loadingNewPage: false),
    ],
  );
  // Erro ao nao retornar nenhum estado

  storeTest<TrendsPhotosStore>(
    'should not fetch new page when state is TabStart',
    build: () {
      when(() => usecaseMock(query)).thenAnswer(
        (invocation) async => Right(
          PhotoRequestResult(
            page: 1,
            perPage: 1,
            photos: [],
            totalResults: 1,
            nextPage: 'url',
          ),
        ),
      );
      when(() => usecaseMock(query, url: 'url')).thenAnswer(
        (invocation) async => Right(
          PhotoRequestResult(
            page: 1,
            perPage: 1,
            photos: [],
            totalResults: 1,
            nextPage: 'url',
          ),
        ),
      );
      return TrendsPhotosStore(usecaseMock);
    },
    act: (store) async {
      await store.fetchNewPage();
      await store.fetchData();
      await store.fetchNewPage();
    },
    expect: () => [
      true,
      TabFetchData(photos: [], nextpage: ''),
      false,
      TabFetchData(photos: [], nextpage: '', loadingNewPage: true),
      TabFetchData(photos: [], nextpage: '', loadingNewPage: false),
    ],
    verify: (store) {
      verify(() => usecaseMock(query)).called(1);
    },
  );
}
