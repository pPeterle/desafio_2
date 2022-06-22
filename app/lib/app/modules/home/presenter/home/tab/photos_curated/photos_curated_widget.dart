import 'package:app/app/modules/home/presenter/home/tab/photos_curated/photos_curated_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../domain/errors/errors.dart';
import '../../state/tab_state.dart';
import '../../widgets/home_error_widget.dart';
import '../../widgets/home_loading.dart';
import '../../widgets/photo_grid_widget.dart';

class PhotosCuratedWidget extends StatefulWidget {
  const PhotosCuratedWidget({Key? key}) : super(key: key);

  @override
  State<PhotosCuratedWidget> createState() => _PhotosCuratedWidgetState();
}

class _PhotosCuratedWidgetState extends State<PhotosCuratedWidget> {
  final PhotosCuratedStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<PhotosCuratedStore, Failure, TabState>(
      store: store,
      onLoading: (context) {
        return const HomeLoading();
      },
      onState: (context, state) {
        if (state is TabFetchData) {
          return PhotoGridWidget(
            photos: state.photos,
            fetchNewData: () {
              store.fetchNewPage();
            },
            loading: state.loadingNewPage,
          );
        }
        return Container();
      },
      onError: (context, error) {
        return HomeErrorWidget(
          callback: () {
            store.fetchData();
          },
          message: 'Error',
        );
      },
    );
  }
}
