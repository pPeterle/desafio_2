import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/usescases/curated_photos/curated_photos_usecase.dart';
import 'package:app/app/modules/home/presenter/home/state/home_state.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PhotosCuratedStore extends NotifierStore<Failure, HomeState> {
  final CuratedPhotosUsecase _curatedPhotosUsecase;
  PhotosCuratedStore(this._curatedPhotosUsecase) : super(HomeStart());

  fetchData() async {
    setLoading(true);
    final result = await _curatedPhotosUsecase();
    result.fold(
      (l) => setError(l),
      (r) => update(
        HomeFetchData(photos: r.photos, nextpage: r.nextPage),
      ),
    );
    setLoading(false);
  }

  fetchNewPage() async {
    if (selectState.value is! HomeFetchData) return;
    final state = (selectState.value as HomeFetchData);
    if (state.loadingNewPage || isLoading) return;

    update(
      HomeFetchData(
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
        HomeFetchData(
          photos: [...state.photos, ...r.photos],
          nextpage: r.nextPage,
        ),
      ),
    );
  }
}
