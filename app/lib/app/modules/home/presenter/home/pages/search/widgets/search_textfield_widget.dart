import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../search_store.dart';

class SearchAppbarWidget extends StatelessWidget with PreferredSizeWidget {
  final SearchStore store = Modular.get();
  final TextEditingController editingController;

  SearchAppbarWidget({Key? key, required this.editingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: TextField(
        controller: editingController,
        autofocus: true,
        cursorColor: theme.colorScheme.onPrimary.withOpacity(.5),
        onChanged: store.onQueryChange,
        decoration: const InputDecoration(
          hintText: 'Search',
        ),
      ),
      iconTheme: IconThemeData(
        color: theme.colorScheme.onPrimary, //change your color here
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_outlined),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
