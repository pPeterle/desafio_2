import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  final Photo photo;
  const PhotoPage({Key? key, required this.photo}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: widget.photo.id,
          child: CachedNetworkImage(
            imageUrl: widget.photo.src.portrait!,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(
                    color: theme.colorScheme.onPrimary, //change your color here
                  ),
                  actions: const [
                    Icon(
                      Icons.more_vert,
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'DOWNLOAD',
                            style:
                                TextStyle(color: theme.colorScheme.onPrimary),
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
