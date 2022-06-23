import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/state/search_state.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:rxdart/rxdart.dart';

class SearchStore extends NotifierStore<Failure, SearchState> {
  final SearchPhotosUsecase _searchPhotosUsecase;
  final BehaviorSubject<String> _behaviorSubject = BehaviorSubject();

  SearchStore(this._searchPhotosUsecase) : super(SearchStart()) {
    _behaviorSubject
        .debounceTime(const Duration(milliseconds: 600))
        .distinct()
        .listen(_fetchPhotos);
  }

  void onQueryChange(String query) {
    _behaviorSubject.sink.add(query);
  }

  void fetchNewPage(String query) async {
    if (state is! SearchFetchData) return;

    final searchFetchData = (state as SearchFetchData);
    if (searchFetchData.loadingNewPage || isLoading) return;

    update(
      SearchFetchData(
        photos: searchFetchData.photos,
        nextpage: searchFetchData.nextpage,
        loadingNewPage: true,
        query: query,
      ),
    );

    final result =
        await _searchPhotosUsecase(query, url: searchFetchData.nextpage);

    result.fold(
      (l) => setError(l),
      (r) => update(
        SearchFetchData(
          photos: [...searchFetchData.photos, ...r.photos],
          nextpage: r.nextPage,
          query: query,
        ),
      ),
    );
  }

  Future _fetchPhotos(String query) async {
    setLoading(true);
    final result = await _searchPhotosUsecase(query);
    result.fold(
      (l) => setError(l),
      (r) => update(
        SearchFetchData(
          photos: r.photos,
          nextpage: r.nextPage,
          query: query,
        ),
      ),
    );
    setLoading(false);
  }

  void reset() {
    update(SearchStart());
  }

  @override
  Future destroy() {
    _behaviorSubject.close();
    return super.destroy();
  }
}
