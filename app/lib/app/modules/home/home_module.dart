import 'package:app/app/modules/home/domain/usescases/curated_photos/curated_photos_impl.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase_impl.dart';
import 'package:app/app/modules/home/external/datasource/pexels_datasource.dart';
import 'package:app/app/modules/home/infra/repositories/photo_repository_impl.dart';
import 'package:app/app/modules/home/presenter/home/pages/photo/photo_page.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_curated/photos_curated_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'presenter/home/home_store.dart';

import 'presenter/home/home_page.dart';
import 'util/dio/custom_dio.dart';
import 'util/dio/interceptors/token_interceptor.dart';

const photoRoute = '/photo';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => TokenInterceptor()),
    Bind.singleton((i) => CustomDio(i.get())),
    Bind.singleton((i) => PexelsDatasource(i.get())),
    Bind.singleton((i) => SearchPhotosUsecaseImpl(i.get())),
    Bind.singleton((i) => PhotoRepositoryImpl(i.get())),
    Bind.singleton((i) => CuratedPhotosImpl(i.get())),
    Bind.lazySingleton((i) => HomeStore(i.get())),
    Bind.lazySingleton((i) => PhotosCuratedStore(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
    ChildRoute(
      photoRoute,
      child: (_, args) => PhotoPage(photo: args.data),
    ),
  ];
}
