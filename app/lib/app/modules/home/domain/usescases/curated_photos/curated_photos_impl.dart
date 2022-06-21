import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:app/app/modules/home/domain/util/usecase_mixin.dart';
import 'package:dartz/dartz.dart';

import 'curated_photos_usecase.dart';

class CuratedPhotosImpl with UsecaseMixin implements CuratedPhotosUsecase {
  final PhotoRepository _repository;

  CuratedPhotosImpl(this._repository);

  @override
  Future<Either<Failure, PhotoRequestResult>> call({
    String? url,
  }) async {
    try {
      int page = 1;
      if (url != null) {
        page = getPageFromUrl(url);
      }
      return _repository.getCuratedPhotos(page: page);
    } on InvalidUrlError catch (e) {
      return Left(e);
    }
  }
}
