import 'package:app/app/modules/home/presenter/home/tab/photos_curated/photos_curated_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../domain/errors/errors.dart';
import '../../state/home_state.dart';
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
    final theme = Theme.of(context);
    return ScopedBuilder<PhotosCuratedStore, Failure, HomeState>(
      store: store,
      onLoading: (context) {
        return const HomeLoading();
      },
      onState: (context, state) {
        if (state is HomeFetchData) {
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
        print(error);
        return Container();
      },
    );
  }
}
