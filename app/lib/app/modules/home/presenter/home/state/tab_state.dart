import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:equatable/equatable.dart';

abstract class TabState {}

class TabStart extends TabState {}

class TabFetchData extends TabState with EquatableMixin {
  final List<Photo> photos;
  final String? nextpage;
  final bool loadingNewPage;

  TabFetchData({
    required this.photos,
    this.nextpage,
    this.loadingNewPage = false,
  });

  @override
  List<Object> get props {
    return [photos, loadingNewPage];
  }
}

class TabFetchingNewPage extends TabFetchData {
  TabFetchingNewPage({required super.photos});
}
