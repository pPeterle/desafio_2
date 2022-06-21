import 'package:app/app/modules/home/domain/entities/photo.dart';

abstract class HomeState {}

class HomeStart extends HomeState {}

class HomeFetchData extends HomeState {
  final List<Photo> photos;
  final String? nextpage;
  final bool loadingNewPage;

  HomeFetchData({
    required this.photos,
    this.nextpage,
    this.loadingNewPage = false,
  });
}

class HomeFetchingNewPage extends HomeFetchData {
  HomeFetchingNewPage({required super.photos});
}
