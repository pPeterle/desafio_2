import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = dotenv.env['PEXELS_TOKEN'];
    options.headers.putIfAbsent('Authorization', () => token);
    super.onRequest(options, handler);
  }
}
