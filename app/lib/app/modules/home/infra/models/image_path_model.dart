import 'package:app/app/modules/home/domain/entities/image_path.dart';

class ImagePathModel extends ImagePath {
  ImagePathModel({
    required super.original,
    super.large2x,
    super.large,
    super.medium,
    super.small,
    super.portrait,
    super.landscape,
    super.tiny,
  });

  factory ImagePathModel.fromJson(Map<String, dynamic> json) => ImagePathModel(
        original: json['original'] as String,
        large2x: json['large2x'] as String?,
        large: json['large'] as String?,
        medium: json['medium'] as String?,
        small: json['small'] as String?,
        portrait: json['portrait'] as String?,
        landscape: json['landscape'] as String?,
        tiny: json['tiny'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'original': original,
        'large2x': large2x,
        'large': large,
        'medium': medium,
        'small': small,
        'portrait': portrait,
        'landscape': landscape,
        'tiny': tiny,
      };

  ImagePathModel copyWith({
    String? original,
    String? large2x,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) {
    return ImagePathModel(
      original: original ?? this.original,
      large2x: large2x ?? this.large2x,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
      portrait: portrait ?? this.portrait,
      landscape: landscape ?? this.landscape,
      tiny: tiny ?? this.tiny,
    );
  }

  ImagePath mapToDomain() => ImagePath(
        original: original,
        landscape: landscape,
        large2x: large2x,
        large: large,
        medium: medium,
        portrait: portrait,
        small: small,
        tiny: tiny,
      );
}
