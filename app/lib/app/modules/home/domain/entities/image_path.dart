class ImagePath {
  String original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  ImagePath({
    required this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });
}
