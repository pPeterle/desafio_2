import 'package:app/app/modules/home/domain/entities/photo.dart';

abstract class TabState {}

class TabStart extends TabState {}

class TabFetchData extends TabState {
  final List<Photo> photos;
  final String? nextpage;
  final bool loadingNewPage;

  TabFetchData({
    required this.photos,
    this.nextpage,
    this.loadingNewPage = false,
  });
}

class TabFetchingNewPage extends TabFetchData {
  TabFetchingNewPage({required super.photos});
}
