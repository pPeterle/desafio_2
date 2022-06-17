import 'package:app/app/modules/home/util/dio/interceptors/token_interceptor.dart';
import 'package:app/app/modules/home/util/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio extends DioForNative {
  final TokenInterceptor tokenInterceptor;

  CustomDio(this.tokenInterceptor) : super(BaseOptions(baseUrl: baseUrl)) {
    interceptors.add(tokenInterceptor);
    if (dotenv.env['ENVIRONMENT'] == 'DEVELOPMENT') {
      interceptors.add(LogInterceptor());
    }
  }
}
