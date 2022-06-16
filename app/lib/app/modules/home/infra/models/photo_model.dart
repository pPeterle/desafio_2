import 'package:app/app/modules/home/domain/entities/photo.dart';

import 'image_path_model.dart';

class PhotoModel extends Photo {
  PhotoModel({
    required super.id,
    required super.width,
    required super.height,
    required super.url,
    required super.photographer,
    required super.photographerUrl,
    required super.photographerId,
    required super.avgColor,
    required super.src,
    required super.liked,
    required super.alt,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: json['id'] as int,
        width: json['width'] as int,
        height: json['height'] as int,
        url: json['url'] as String,
        photographer: json['photographer'] as String,
        photographerUrl: json['photographer_url'] as String,
        photographerId: json['photographer_id'] as int,
        avgColor: json['avg_color'] as String,
        src: ImagePathModel.fromJson(json['src'] as Map<String, dynamic>),
        liked: json['liked'] as bool,
        alt: json['alt'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'avg_color': avgColor,
        'src': (src as ImagePathModel).toJson(),
        'liked': liked,
        'alt': alt,
      };

  PhotoModel copyWith({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    ImagePathModel? src,
    bool? liked,
    String? alt,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      url: url ?? this.url,
      photographer: photographer ?? this.photographer,
      photographerUrl: photographerUrl ?? this.photographerUrl,
      photographerId: photographerId ?? this.photographerId,
      avgColor: avgColor ?? this.avgColor,
      src: src ?? this.src,
      liked: liked ?? this.liked,
      alt: alt ?? this.alt,
    );
  }

  Photo mapToDomain() => Photo(
        id: id,
        width: width,
        height: height,
        url: url,
        photographer: photographer,
        photographerUrl: photographerUrl,
        photographerId: photographerId,
        avgColor: avgColor,
        src: src,
        liked: liked,
        alt: alt,
      );
}
