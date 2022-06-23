import 'package:flutter/material.dart';

class PhotoRatingWidget extends StatelessWidget {
  const PhotoRatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
      ],
    );
  }
}
