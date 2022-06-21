import '../errors/errors.dart';

mixin UsecaseMixin {
  int getPageFromUrl(String url) {
    final regex = RegExp(r'[?&]page=(\d+)');
    final page = regex.firstMatch(url)?.group(1);

    if (page == null) throw InvalidUrlError();

    return int.parse(page);
  }
}
