import 'package:flutter/material.dart';

class PhotoActionsButtons extends StatelessWidget {
  final VoidCallback onDownload;
  const PhotoActionsButtons({Key? key, required this.onDownload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onDownload,
              child: Text(
                'DOWNLOAD',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 36,
            ),
          )
        ],
      ),
    );
  }
}
