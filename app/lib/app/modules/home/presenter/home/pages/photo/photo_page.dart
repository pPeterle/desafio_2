import 'package:app/app/modules/home/domain/entities/photo.dart';
import 'package:app/app/modules/home/presenter/home/pages/photo/widgets/photo_appbar_widget.dart';
import 'package:app/app/modules/home/presenter/home/pages/photo/widgets/photo_rating_widget..dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:ui';
import 'dart:isolate';

import 'package:path_provider/path_provider.dart';

import 'widgets/photo_actions_buttons_widget.dart';

class PhotoPage extends StatefulWidget {
  final Photo photo;
  const PhotoPage({Key? key, required this.photo}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final ReceivePort _port = ReceivePort();
  bool isOpenDialog = false;

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.complete) {
        Modular.to.pop();
      } else if (status == DownloadTaskStatus.failed) {
        showErrorDialog(context);
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const PhotoAppbarWidget(),
                const Spacer(),
                const PhotoRatingWidget(),
                PhotoActionsButtons(
                  onDownload: () {
                    downloadImage(context);
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showErrorDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Erro ao fazer download"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Modular.to.pop();
          },
          child: const Text('Close'),
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  downloadImage(BuildContext context) async {
    showLoaderDialog(context);
    final directory = await getExternalStorageDirectory();
    await FlutterDownloader.enqueue(
      url: widget.photo.src.original,
      savedDir: directory!.path,
      fileName: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }
}
