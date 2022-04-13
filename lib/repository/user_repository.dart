import 'dart:convert' as convert;

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

  String? get phone => _localDataProvider.phone();
  String? get post => _localDataProvider.post();
  String? get company => _localDataProvider.company();
  String? get idCard => _localDataProvider.idCard();

  Future<UserResponse> login(String username, String password) async {
    var response = await _apiDataProvider.login(username, password);
    await _localDataProvider.setIsLogin(true);
    await _localDataProvider.setToken(response.token);
    await _localDataProvider.setUserName(response.userInfo.username);
    await _localDataProvider.setNickname(response.userInfo.realname);
    await _localDataProvider.setAvatar(response.userInfo.avatar ?? "");

    await _localDataProvider.setPhone(response.userInfo.phone ?? "");
    await _localDataProvider.setPost(response.userInfo.post ?? "");
    await _localDataProvider.setCompany(response.userInfo.company ?? "");
    await _localDataProvider.setIdCard(response.userInfo.idCard ?? "");
    return response.userInfo;
  }

  Future<void> logout() async {
    await _localDataProvider.setIsLogin(false);
    await _localDataProvider.setToken('');
    await _localDataProvider.setUserName('');
    await _localDataProvider.setNickname('');
    await _localDataProvider.setAvatar('');
    await _localDataProvider.setPhone('');
    await _localDataProvider.setPost('');
    await _localDataProvider.setCompany('');
    await _localDataProvider.setIdCard('');
  }

  Future<void> freshUserInfo() async {
    var loginResponse = await _apiDataProvider.getUserInfo();
    var userInfo = loginResponse.userInfo;

    await _localDataProvider.setUserName(userInfo.username);
    await _localDataProvider.setNickname(userInfo.realname);
    await _localDataProvider.setAvatar(userInfo.avatar ?? "");

    await _localDataProvider.setPhone(userInfo.phone ?? "");
    await _localDataProvider.setPost(userInfo.post ?? "");
    await _localDataProvider.setCompany(userInfo.company ?? "");
    await _localDataProvider.setIdCard(userInfo.idCard ?? "");
  }

  Future<Response<void>> updatePassword(
      String oldPassword, String newPassword) async {
    return await _apiDataProvider.modifyPassword(oldPassword, newPassword);
  }

  Future<Response<void>> resetPassword(
      String phone, String password, String verifyCode) async {
    return await _apiDataProvider.resetPassword(phone, password, verifyCode);
  }

  Future<Response<void>> sendSmsVerifyCode(String phone) async {
    return await _apiDataProvider.sendSmsVerifyCode(phone);
  }
}
