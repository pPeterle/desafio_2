import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState {}

class SearchStart extends SearchState {}

class SearchFetchData extends SearchState with EquatableMixin {
  final List<Photo> photos;
  final String? nextpage;
  final bool loadingNewPage;
  final String query;

  SearchFetchData({
    required this.photos,
    required this.query,
    this.nextpage,
    this.loadingNewPage = false,
  });

  @override
  List<Object?> get props => [photos, nextpage, query];
}

class SearchFetchingNewPage extends SearchFetchData {
  SearchFetchingNewPage({required super.photos, required super.query});
}
