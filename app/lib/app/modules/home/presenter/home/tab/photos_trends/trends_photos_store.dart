import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/state/tab_state.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TrendsPhotosStore extends NotifierStore<Failure, TabState> {
  final SearchPhotosUsecase _searchPhotosUsecase;
  TrendsPhotosStore(this._searchPhotosUsecase) : super(TabStart());

  final query = 'Trends';

  fetchData() async {
    if (state is! TabStart) return;

    setLoading(true);
    final result = await _searchPhotosUsecase(query);
    result.fold(
      (l) => setError(l),
      (r) => update(
        TabFetchData(photos: r.photos, nextpage: r.nextPage),
      ),
    );
    setLoading(false);
  }

  fetchNewPage() async {
    if (selectState.value is! TabFetchData) return;
    final state = (selectState.value as TabFetchData);
    if (state.loadingNewPage || isLoading) return;

    update(
      TabFetchData(
        photos: state.photos,
        nextpage: state.nextpage,
        loadingNewPage: true,
      ),
    );
    await Future.delayed(const Duration(seconds: 10));

    final result = await _searchPhotosUsecase(query, url: state.nextpage);

    result.fold(
      (l) => setError(l),
      (r) => update(
        TabFetchData(
          photos: [...state.photos, ...r.photos],
          nextpage: r.nextPage,
        ),
      ),
    );
  }
}
