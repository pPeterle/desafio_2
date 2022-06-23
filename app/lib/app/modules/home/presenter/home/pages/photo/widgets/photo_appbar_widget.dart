import 'package:flutter/material.dart';

class PhotoAppbarWidget extends StatelessWidget {
  const PhotoAppbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: theme.colorScheme.onPrimary, //change your color here
      ),
      actions: const [
        Icon(
          Icons.more_vert,
        )
      ],
    );
  }
}
