import 'package:flutter/material.dart';

mixin ShowErrorMixin {
  showErrorSnackBar(BuildContext context, VoidCallback callback) {
    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Algum erro',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
        action: SnackBarAction(
          label: 'Retry',
          textColor: colorScheme.onSecondary,
          onPressed: callback,
        ),
        backgroundColor: colorScheme.secondary,
        duration: const Duration(days: 1),
      ),
    );
  }
}
