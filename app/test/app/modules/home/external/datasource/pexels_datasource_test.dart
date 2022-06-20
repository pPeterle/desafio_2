import 'package:app/app/modules/home/domain/errors/errors.dart';
import 'package:app/app/modules/home/external/datasource/pexels_datasource.dart';
import 'package:app/app/modules/home/infra/models/photo_request_result_model.dart';
import 'package:app/app/modules/home/util/dio/custom_dio.dart';
import 'package:app/app/modules/home/util/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/fake_pexels_json.dart';

class CustomDioMock extends Mock implements CustomDio {}

void main() {
  final CustomDioMock dio = CustomDioMock();
  final PexelsDatasource datasource = PexelsDatasource(dio);

  test('should return PhotoRequestModel on success', () async {
    when(
      () => dio.get(
        searchPhotoUrl,
        queryParameters: {
          'query': 'Animals',
          'page': 1,
        },
      ),
    ).thenAnswer(
      (invocation) async => Response(
        statusCode: 200,
        data: fakePexelsJson,
        requestOptions: RequestOptions(
          path: '',
        ),
      ),
    );

    final result = await datasource.searchPhotos('Animals');

    expect(result, isA<PhotoRequestResultModel>());
  });

  test('should return DatasourceErro on error', () async {
    when(
      () => dio.get(
        searchPhotoUrl,
        queryParameters: {
          'query': 'Animals',
          'page': 1,
        },
      ),
    ).thenThrow(
      DioError(
        requestOptions: RequestOptions(
          path: '',
        ),
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(
            path: '',
          ),
        ),
      ),
    );

    try {
      await datasource.searchPhotos('Animals');
      fail('Should throw exception on code 500');
    } catch (e) {
      expect(e, isA<DataSourceError>());
    }
  });

  test('should return InvalidQueryError on empty query', () async {
    when(
      () => dio.get(
        searchPhotoUrl,
        queryParameters: {
          'query': '',
          'page': 1,
        },
      ),
    ).thenThrow(
      DioError(
        requestOptions: RequestOptions(
          path: '',
        ),
        response: Response(
          statusCode: 400,
          requestOptions: RequestOptions(
            path: '',
          ),
        ),
      ),
    );

    try {
      await datasource.searchPhotos('');
      fail('Should throw exception on code 500');
    } catch (e) {
      expect(e, isA<InvalidQueryError>());
    }
  });
}
