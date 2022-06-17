import 'package:app/app/modules/home/infra/models/photo_request_result_model.dart';

abstract class PhotoRemoteDatasource {
  Future<PhotoRequestResultModel> searchPhotos(String query, {int page = 1});
}
