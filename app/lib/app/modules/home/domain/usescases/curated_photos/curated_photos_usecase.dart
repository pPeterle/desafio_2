import 'package:dartz/dartz.dart';

import '../../entities/photo_request_result.dart';
import '../../errors/errors.dart';

abstract class CuratedPhotosUsecase {
  Future<Either<Failure, PhotoRequestResult>> call({String? url});
}
