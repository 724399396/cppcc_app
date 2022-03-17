import 'package:cppcc_app/dto/discuss_network_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';

class DiscussNetworkRepository {
  final ApiDataProvider _apiDataProvider;

  DiscussNetworkRepository(this._apiDataProvider);

  Future<DiscussNetworkResponseWrapper> getListPage(
      int pageNo, int pageSize, String status) async {
    var response =
        await _apiDataProvider.getDiscussNetworkList(pageNo, pageSize, status);
    return response;
  }
}
