import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/infra/datasource/photo_remote_datasource.dart';
import 'package:app/app/modules/home/infra/models/photo_request_result_model.dart';
import 'package:app/app/modules/home/util/dio/custom_dio.dart';

import '../../util/urls.dart';

class PexelsDatasource implements PhotoRemoteDatasource {
  final CustomDio _dio;

  PexelsDatasource(this._dio);

  @override
  Future<PhotoRequestResultModel> searchPhotos(
    String query, {
    int page = 1,
  }) async {
    final result = await _dio.get(
      searchPhotoUrl,
      queryParameters: {
        'query': query,
        'page': page,
      },
    );
    if (result.statusCode == 200) {
      return PhotoRequestResultModel.fromJson(result.data);
    } else {
      throw DataSourceError();
    }
  }
}
