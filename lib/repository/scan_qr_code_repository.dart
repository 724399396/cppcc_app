import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class ScanQrCodeRepository {
  final ApiDataProvider _apiDataProvider;

  ScanQrCodeRepository(this._apiDataProvider);

  Future<BaseResponse> get(String uri) {
    return _apiDataProvider.get(uri);
  }
}
