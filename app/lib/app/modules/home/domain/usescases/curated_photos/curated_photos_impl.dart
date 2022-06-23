import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/domain/repository/photo_repository.dart';
import 'package:dartz/dartz.dart';

import '../../util/domain_util.dart';
import 'curated_photos_usecase.dart';

class CuratedPhotosImpl implements CuratedPhotosUsecase {
  final PhotoRepository _repository;

  CuratedPhotosImpl(this._repository);

  @override
  Future<Either<Failure, PhotoRequestResult>> call({
    String? url,
  }) async {
    try {
      int page = 1;
      if (url != null) {
        page = DomainUtil.getPageFromUrl(url);
      }
      return _repository.getCuratedPhotos(page: page);
    } on InvalidUrlError catch (e) {
      return Left(e);
    }
  }
}
