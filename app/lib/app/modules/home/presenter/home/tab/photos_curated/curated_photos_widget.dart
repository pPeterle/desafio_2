import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../domain/errors/errors.dart';
import '../../state/tab_state.dart';
import '../../widgets/home_error_widget.dart';
import '../../widgets/home_loading.dart';
import '../../widgets/photo_grid_widget.dart';
import 'curated_photos_store.dart';

class CuratedPhotosWidget extends StatefulWidget {
  const CuratedPhotosWidget({Key? key}) : super(key: key);

  @override
  State<CuratedPhotosWidget> createState() => _CuratedPhotosWidgetState();
}

class _CuratedPhotosWidgetState extends State<CuratedPhotosWidget> {
  final CuratedPhotosStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<CuratedPhotosStore, Failure, TabState>(
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
          message: error!.message,
        );
      },
    );
  }
}
