import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/search_store.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/state/search_state.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/widgets/search_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/home_error_widget.dart';
import '../../widgets/home_loading.dart';
import '../../widgets/photo_grid_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchStore store = Modular.get();
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    store.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: SearchAppbarWidget(editingController: _editingController),
      backgroundColor: theme.colorScheme.secondary,
      body: ScopedBuilder<SearchStore, Failure, SearchState>(
        store: store,
        onLoading: (context) {
          return const HomeLoading();
        },
        onState: (context, state) {
          if (state is SearchFetchData) {
            if (state.photos.isEmpty) {
              return const Center(
                child: Text('No results'),
              );
            }
            return PhotoGridWidget(
              photos: state.photos,
              fetchNewData: () {
                store.fetchNewPage(_editingController.text);
              },
              loading: state.loadingNewPage,
            );
          }
          return Container();
        },
        onError: (context, error) {
          if (error is InvalidQueryError) {
            return const Center(
              child: Text('Empty search'),
            );
          }
          return Center(
            child: HomeErrorWidget(
              callback: () {
                store.onQueryChange('${_editingController.text} ');
              },
              message: error!.message,
            ),
          );
        },
      ),
    );
  }
}
