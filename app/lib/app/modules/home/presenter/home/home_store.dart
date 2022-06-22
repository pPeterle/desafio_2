import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/state/tab_state.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends NotifierStore<Failure, TabState> {
  final SearchPhotosUsecase _searchPhotosUsecase;
  HomeStore(this._searchPhotosUsecase) : super(TabStart());

  fetchData() async {
    setLoading(true);
    final result = await _searchPhotosUsecase('Trends');
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
    final result = await _searchPhotosUsecase('Trends', url: state.nextpage);

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
