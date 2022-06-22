import 'package:app/app/modules/home/presenter/home/tab/photos_animals/photos_animals_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../domain/errors/errors.dart';
import '../../state/tab_state.dart';
import '../../widgets/home_error_widget.dart';
import '../../widgets/home_loading.dart';
import '../../widgets/photo_grid_widget.dart';

class PhotosAnimalsWidget extends StatefulWidget {
  const PhotosAnimalsWidget({Key? key}) : super(key: key);

  @override
  State<PhotosAnimalsWidget> createState() => _PhotosAnimalsWidgetState();
}

class _PhotosAnimalsWidgetState extends State<PhotosAnimalsWidget> {
  final PhotosAnimalsStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<PhotosAnimalsStore, Failure, TabState>(
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
