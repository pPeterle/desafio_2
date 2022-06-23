import 'package:app/app/modules/home/domain/usescases/curated_photos/curated_photos_impl.dart';
import 'package:app/app/modules/home/domain/usescases/search_photos/search_photos_usecase_impl.dart';
import 'package:app/app/modules/home/external/datasource/pexels_datasource.dart';
import 'package:app/app/modules/home/external/util/dio/interceptors/connectivity_interceptor.dart';
import 'package:app/app/modules/home/infra/repositories/photo_repository_impl.dart';
import 'package:app/app/modules/home/presenter/home/pages/photo/photo_page.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/search_page.dart';
import 'package:app/app/modules/home/presenter/home/pages/search/search_store.dart';
import 'package:app/app/modules/home/presenter/home/tab/animals_photos/animals_photos_store.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_curated/curated_photos_store.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_trends/trends_photos_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'external/util/dio/custom_dio.dart';
import 'external/util/dio/interceptors/token_interceptor.dart';

import 'presenter/home/home_page.dart';

const photoRoute = '/photo';
const searchRoute = '/search';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => TokenInterceptor()),
    Bind.singleton((i) => ConnectivityInterceptor()),
    Bind.singleton((i) => CustomDio(i.get(), i.get())),
    Bind.singleton((i) => PexelsDatasource(i.get())),
    Bind.singleton((i) => SearchPhotosUsecaseImpl(i.get())),
    Bind.singleton((i) => PhotoRepositoryImpl(i.get())),
    Bind.singleton((i) => CuratedPhotosImpl(i.get())),
    Bind.singleton((i) => TrendsPhotosStore(i.get())),
    Bind.singleton((i) => AnimalsPhotosStore(i.get())),
    Bind.singleton((i) => CuratedPhotosStore(i.get())),
    Bind.singleton((i) => SearchStore(i.get())),
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
    ChildRoute(
      searchRoute,
      child: (_, args) => const SearchPage(),
    ),
  ];
}
