import 'package:cppcc_app/dto/dict_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class AppSettingRepository {
  final ApiDataProvider _apiDataProvider;

  AppSettingRepository(this._apiDataProvider);

  Future<List<DictResponse>> getDict() {
    return _apiDataProvider.getDict();
  }

}
