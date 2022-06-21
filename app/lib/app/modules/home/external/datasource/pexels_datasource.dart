import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/infra/datasource/photo_remote_datasource.dart';
import 'package:app/app/modules/home/infra/models/photo_request_result_model.dart';
import 'package:app/app/modules/home/util/dio/custom_dio.dart';
import 'package:dio/dio.dart';

import '../../util/urls.dart';

class PexelsDatasource implements PhotoRemoteDatasource {
  final CustomDio _dio;

  PexelsDatasource(this._dio);

  @override
  Future<PhotoRequestResultModel> searchPhotos(
    String query, {
    int page = 1,
  }) async {
    try {
      final result = await _dio.get(
        searchPhotoUrl,
        queryParameters: {'query': query, 'page': page, 'per_page': 30},
      );

      return PhotoRequestResultModel.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw InvalidQueryError();
      }
      throw DataSourceError();
    }
  }

  @override
  Future<PhotoRequestResultModel> getCuratedPhotos({
    int page = 1,
  }) async {
    final result = await _dio.get(
      curatedPhotoUrl,
      queryParameters: {'page': page, 'per_page': 30},
    );

    return PhotoRequestResultModel.fromJson(result.data);
  }
}
