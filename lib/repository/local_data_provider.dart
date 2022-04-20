import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  final String _isUserLogin = 'isUserLogin';
  final String _userToken = 'userToken';

  late SharedPreferences _sharedPreferences;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isLogin() => _sharedPreferences.getBool(_isUserLogin) ?? false;
  String? token() => _sharedPreferences.getString(_userToken);

  setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(_isUserLogin, isLogin);
  }

  setToken(String token) async {
    await _sharedPreferences.setString(_userToken, token);
  }
}
