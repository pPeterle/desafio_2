import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/curated_photos/curated_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/state/tab_state.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CuratedPhotosStore extends NotifierStore<Failure, TabState> {
  final CuratedPhotosUsecase _curatedPhotosUsecase;
  CuratedPhotosStore(this._curatedPhotosUsecase) : super(TabStart());

  Future fetchData() async {
    if (state is! TabStart) return;

    setLoading(true);
    final result = await _curatedPhotosUsecase();
    result.fold(
      (l) => setError(l),
      (r) => update(
        TabFetchData(photos: r.photos, nextpage: r.nextPage),
      ),
    );
    setLoading(false);
  }

  Future fetchNewPage() async {
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

    final result = await _curatedPhotosUsecase(url: state.nextpage);

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
