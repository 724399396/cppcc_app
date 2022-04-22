import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/models/guandu_historical_clue.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class GuanduHistoricalClueRepository {
  final ApiDataProvider _apiDataProvider;

  GuanduHistoricalClueRepository(this._apiDataProvider);

  Future<List<GuanduHistoricalClue>> getList(int pageNo, int pageSize) async {
    var response =
        await _apiDataProvider.getHistoricalClueList(pageNo, pageSize);
    return response.records
        .map((e) => GuanduHistoricalClue(
            content: e.content ?? '',
            createBy: e.createBy ?? '',
            createTime: e.createTime ?? '',
            id: e.id,
            phone: e.phone ?? '',
            provider: e.provider ?? '',
            read: e.read ?? false,
            title: e.title ?? '',
            unit: e.unit ?? ''))
        .toList();
  }

  Future<BaseResponse> addHistoricalClue(String title, String unit,
      String provider, String phone, String content) async {
    var response = await _apiDataProvider.addHistoricalClue(
        title, unit, provider, phone, content);
    return response;
  }
}
