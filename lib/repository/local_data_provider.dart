import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  final String _isUserLogin = 'isUserLogin';
  final String _userToken = 'userToken';
  final String _username = 'username';
  final String _nickname = 'nickname';
  final String _avatar = 'avatar';

  late SharedPreferences _sharedPreferences;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isLogin() => _sharedPreferences.getBool(_isUserLogin) ?? false;
  String? token() => _sharedPreferences.getString(_userToken);
  String? username() => _sharedPreferences.getString(_username);
  String? nickname() => _sharedPreferences.getString(_nickname);
  String? avatar() => _sharedPreferences.getString(_avatar);

  setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(_isUserLogin, isLogin);
  }

  setToken(String token) async {
    await _sharedPreferences.setString(_userToken, token);
  }

  setUserName(String username) async {
    await _sharedPreferences.setString(_username, username);
  }

  setNickname(String nickname) async {
    await _sharedPreferences.setString(_nickname, nickname);
  }

  setAvatar(String avatar) async {
    await _sharedPreferences.setString(_avatar, avatar);
  }
}
