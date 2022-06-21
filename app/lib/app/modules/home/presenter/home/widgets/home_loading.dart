import 'package:flutter/material.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(theme.colorScheme.onPrimary),
      ),
    );
  }
}
