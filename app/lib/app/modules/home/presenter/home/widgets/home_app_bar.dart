import 'package:flutter/material.dart';

class HomeAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.secondary,
      actions: [
        IconButton(
          onPressed: () {},
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
