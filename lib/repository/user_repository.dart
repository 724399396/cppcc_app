import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final LocalDataProvider _localDataProvider;
  final ApiDataProvider _apiDataProvider;

  UserRepository(this._localDataProvider, this._apiDataProvider);

  bool get isLogin => _localDataProvider.isLogin();
  String? get token => _localDataProvider.token();
  String? get username => _localDataProvider.username();
  String? get nickname => _localDataProvider.nickname();
  String? get avatar => _localDataProvider.avatar();

  Future<UserResponse> login(String username, String password) async {
    var response = await _apiDataProvider.login(username, password);
    await _localDataProvider.setIsLogin(true);
    await _localDataProvider.setToken(response.token);
    await _localDataProvider.setUserName(response.userInfo.username);
    await _localDataProvider.setNickname(response.userInfo.realname);
    await _localDataProvider.setAvatar(response.userInfo.avatar ?? "");
    return response.userInfo;
  }

  Future<void> logout() async {
    await _localDataProvider.setIsLogin(false);
    await _localDataProvider.setToken('');
    await _localDataProvider.setUserName('');
    await _localDataProvider.setNickname('');
    await _localDataProvider.setAvatar('');
  }

  Future<Response<void>> updatePassword(
      String oldPassword, String newPassword) async {
    return await _apiDataProvider.modifyPassword(oldPassword, newPassword);
  }

  Future<Response<void>> resetPassword(String password) async {
    return await _apiDataProvider.resetPassword(password);
  }
}
