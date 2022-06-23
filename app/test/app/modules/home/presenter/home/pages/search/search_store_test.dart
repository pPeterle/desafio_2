import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/search_store.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/state/search_state.dart';
import 'package:app/app/modules/home/presenter/home/state/tab_state.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_curated/curated_photos_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:triple_test/triple_test.dart';

class SearchPhotosUsecaseMock extends Mock implements SearchPhotosUsecase {}

class MockCounterStore extends MockStore<Failure, TabState>
    implements CuratedPhotosStore {}

void main() {
  late SearchPhotosUsecaseMock usecaseMock;
  late String query;

  setUp(() {
    usecaseMock = SearchPhotosUsecaseMock();
  });

  storeTest<SearchStore>(
    'should fetch data',
    build: () {
      query = 'animals';
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
      return SearchStore(usecaseMock);
    },
    act: (store) => store.onQueryChange(query),
    expect: () =>
        [true, SearchFetchData(photos: [], query: query, nextpage: ''), false],
  );

  // storeTest<SearchStore>(
  //   'should fetch new page',
  //   build: () {
  //     query = 'animals';
  //     when(() => usecaseMock(any())).thenAnswer(
  //       (invocation) async => Right(
  //         PhotoRequestResult(
  //           page: 1,
  //           perPage: 1,
  //           photos: [],
  //           totalResults: 1,
  //           nextPage: 'url',
  //         ),
  //       ),
  //     );

  //     when(() => usecaseMock(any(), url: 'url')).thenAnswer(
  //       (invocation) async => Right(
  //         PhotoRequestResult(
  //           page: 1,
  //           perPage: 1,
  //           photos: [],
  //           totalResults: 1,
  //           nextPage: 'url',
  //         ),
  //       ),
  //     );

  //     return SearchStore(usecaseMock);
  //   },
  //   act: (store) async {
  //     store.onQueryChange(query);
  //     await Future.delayed(const Duration(seconds: 2));
  //     store.fetchNewPage(query);
  //   },
  //   expect: () => [
  //     true,
  //     SearchFetchData(photos: [], query: query, nextpage: 'url'),
  //     false,
  //     SearchFetchData(
  //       photos: [],
  //       nextpage: 'url',
  //       query: query,
  //       loadingNewPage: true,
  //     ),
  //     SearchFetchData(
  //       photos: [],
  //       nextpage: 'url',
  //       query: query,
  //       loadingNewPage: false,
  //     ),
  //   ],
  // );
}
