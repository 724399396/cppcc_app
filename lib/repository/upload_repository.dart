import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cppcc_app/repository/api_provider.dart';

class FileRepository {
  final ApiDataProvider _apiDataProvider;

  FileRepository(this._apiDataProvider);

  Future<String> upload(File file) async {
    var imageBytes = await file.readAsBytes();
    var fileResponse =
        await _apiDataProvider.upload(imageBytes, p.basename(file.path));
    return fileResponse.url;
  }

  Future<List<int>> download(String url) async {
    var file = await _apiDataProvider.download(url);
    return file;
  }
}
