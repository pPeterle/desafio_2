import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:dartz/dartz.dart';

class SearchPhotosImpl implements SearchPhotosUsecase {
  final PhotoRepository _repository;

  SearchPhotosImpl(this._repository);

  @override
  Future<Either<Failure, PhotoRequestResult>> call(
    String query, {
    String? url,
  }) async {
    try {
      int page = 1;
      if (url != null) {
        page = _getPageFromUrl(url);
      }
      return _repository.searchPhotos(query, page: page);
    } on InvalidUrlError catch (e) {
      return Left(e);
    }
  }

  int _getPageFromUrl(String url) {
    final regex = RegExp(r'[?&]page=(\d+)');
    final page = regex.firstMatch(url)?.group(1);

    if (page == null) throw InvalidUrlError();

    return int.parse(page);
  }
}
