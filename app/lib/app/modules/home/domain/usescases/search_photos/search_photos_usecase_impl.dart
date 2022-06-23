import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../util/domain_util.dart';

class SearchPhotosUsecaseImpl implements SearchPhotosUsecase {
  final PhotoRepository _repository;

  SearchPhotosUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, PhotoRequestResult>> call(
    String query, {
    String? url,
  }) async {
    try {
      int page = 1;
      if (url != null) {
        page = DomainUtil.getPageFromUrl(url);
      }
      if (query.isEmpty) return Left(InvalidQueryError());
      return _repository.searchPhotos(query, page: page);
    } on InvalidUrlError catch (e) {
      return Left(e);
    }
  }
}
