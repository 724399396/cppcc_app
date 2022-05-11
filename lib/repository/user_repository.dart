import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  final LocalDataProvider _localDataProvider;
  final ApiDataProvider _apiDataProvider;

  UserRepository(this._localDataProvider, this._apiDataProvider);

  bool get isLogin => _localDataProvider.isLogin();
  String? get token => _localDataProvider.token();

  Future<UserResponse> login(String username, String password) async {
    var response = await _apiDataProvider.login(username, password);
    await _localDataProvider.setIsLogin(true);
    await _localDataProvider.setToken(response.token);

    return response.userInfo;
  }

  Future<void> logout() async {
    await _localDataProvider.setIsLogin(false);
    await _localDataProvider.setToken('');
  }

  Future<UserResponse> freshUserInfo() async {
    var loginResponse = await _apiDataProvider.getUserInfo();
    return loginResponse.userInfo;
  }

  Future<Response<void>> updatePassword(String newPassword) async {
    return await _apiDataProvider.modifyPassword(newPassword);
  }

  Future<Response<void>> resetPassword(
      String phone, String password, String verifyCode) async {
    return await _apiDataProvider.resetPassword(phone, password, verifyCode);
  }

  Future<Response<void>> sendSmsVerifyCode(String phone) async {
    return await _apiDataProvider.sendSmsVerifyCode(phone);
  }

  Future<String> updateAvatar(XFile avatar) async {
    var fileResponse = await _apiDataProvider.uploadImage(avatar);
    await _apiDataProvider
        .updateUserInfo(UserUpdateRequest(avatar: fileResponse.url));
    return fileResponse.url;
  }

  Future updatePhone(String phone, String verifyCode) {
    return _apiDataProvider.updatePhone(phone, verifyCode);
  }

  Future<String> updateWxQrCode(XFile image) async {
    var fileResponse = await _apiDataProvider.uploadImage(image);
    await _apiDataProvider
        .updateUserInfo(UserUpdateRequest(wxQrCode: fileResponse.url));
    return fileResponse.url;
  }
}
