import 'package:app/app/modules/home/infra/models/photo_request_result_model.dart';

abstract class PhotoRemoteDatasource {
  Future<PhotoRequestResultModel> getPhotos({String? query});
  Future<PhotoRequestResultModel> getPhotosNextPage(String url);
}
