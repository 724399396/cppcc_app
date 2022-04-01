import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/dto/historical_clue_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class HistoricalClueRepository {
  final ApiDataProvider _apiDataProvider;

  HistoricalClueRepository(this._apiDataProvider);

  Future<HistoricalClueWrapper> getListPage(int pageNo, int pageSize) async {
    var response =
        await _apiDataProvider.getHistoricalClueList(pageNo, pageSize);
    return response;
  }

  Future<BaseResponse> addHistoricalClue(String title, String unit, String provider,
      String phone, String content) async {
    var response = await _apiDataProvider.addHistoricalClue(
        title, unit, provider, phone, content);
    return response;
  }
}
