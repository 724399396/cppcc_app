import 'dart:io';

import 'package:cppcc_app/repository/api_provider.dart';
import 'package:uuid/uuid.dart';

class UploadRepository {
  final ApiDataProvider _apiDataProvider;
  var uuid = const Uuid();

  UploadRepository(this._apiDataProvider);

  Future<String> upload(File file) async {
    var imageBytes = await file.readAsBytes();
    var fileResponse = await _apiDataProvider.upload(imageBytes, uuid.v1());
    return fileResponse.url;
  }
}
