import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:app/app/modules/home/home_module.dart';
import 'package:app/app/modules/home/presenter/home/home_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_loading.dart';

class PhotoGridWidget extends StatelessWidget {
  final HomeStore store = Modular.get();

  final List<Photo> photos;
  final VoidCallback? fetchNewData;
  final bool loading;

  PhotoGridWidget({
    Key? key,
    this.fetchNewData,
    required this.photos,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.maxScrollExtent -
                          notification.metrics.pixels <
                      900 &&
                  fetchNewData != null) {
                fetchNewData!();
              }
              return true;
            },
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 800 / 1200,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                if (index == photos.length) {
                  return const HomeLoading();
                }

                final image = photos[index];
                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed(photoRoute, arguments: image);
                  },
                  child: Hero(
                    tag: image.id,
                    child: CachedNetworkImage(
                      imageUrl: image.src.portrait!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                );
              },
              itemCount: loading ? photos.length + 1 : photos.length,
            ),
          ),
        ),
      ],
    );
  }
}
