import 'package:app/app/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final AppStore appStore = Modular.get();
  HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.secondary,
      actions: [
        IconButton(
          onPressed: () {
            appStore.toggleTheme();
          },
          icon: Icon(
            Icons.menu,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ],
      title: Text(
        'Wallpaper',
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
