import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:app/app/modules/home/domain/entities/request_result.dart';

class PhotoRequestResult extends RequestResult {
  final List<Photo> photos;

  PhotoRequestResult({
    required this.photos,
    required super.page,
    required super.perPage,
    required super.totalResults,
    super.nextPage,
  });
}
