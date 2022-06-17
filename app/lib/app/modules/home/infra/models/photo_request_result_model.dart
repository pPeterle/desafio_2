import 'package:app/app/modules/home/domain/entities/photo_request_result.dart';
import 'package:app/app/modules/home/infra/models/photo_model.dart';

class PhotoRequestResultModel extends PhotoRequestResult {
  PhotoRequestResultModel({
    required super.totalResults,
    required super.page,
    required super.perPage,
    required super.photos,
    super.nextPage,
  });

  factory PhotoRequestResultModel.fromJson(Map<String, dynamic> json) {
    final photos = json['photos'] as List;
    return PhotoRequestResultModel(
      totalResults: json['total_results'] as int,
      page: json['page'] as int,
      perPage: json['per_page'] as int,
      nextPage: json['next_page'] as String?,
      photos: photos.map((photo) => PhotoModel.fromJson(photo)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_results': totalResults,
        'page': page,
        'per_page': perPage,
        'next_page': nextPage,
      };

  PhotoRequestResult mapToDomain() => PhotoRequestResult(
        photos: photos,
        page: page,
        perPage: perPage,
        totalResults: totalResults,
        nextPage: nextPage,
      );
}
