import 'package:flutter/material.dart';

class HomeErrorWidget extends StatelessWidget {
  final VoidCallback callback;
  final String message;
  const HomeErrorWidget({
    Key? key,
    required this.message,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        const SizedBox(
          height: 24,
        ),
        OutlinedButton(
          onPressed: callback,
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => theme.colorScheme.error,
            ),
          ),
          child: const Text(
            'Try again',
          ),
        )
      ],
    );
  }
}
