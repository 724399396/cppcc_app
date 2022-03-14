import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  final String _isUserLogin = 'isUserLogin';
  final String _userToken = 'userToken';
  final String _username = 'username';
  final String _nickname = 'nickname';
  final String _avatar = 'avatar';

  final String _phone = 'phone';
  final String _post = 'post';
  final String _company = 'company';
  final String _idCard = 'idCard';

  final String _dictData = 'dictData';

  late SharedPreferences _sharedPreferences;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isLogin() => _sharedPreferences.getBool(_isUserLogin) ?? false;
  String? token() => _sharedPreferences.getString(_userToken);
  String? username() => _sharedPreferences.getString(_username);
  String? nickname() => _sharedPreferences.getString(_nickname);
  String? avatar() => _sharedPreferences.getString(_avatar);

  String? phone() => _sharedPreferences.getString(_phone);
  String? post() => _sharedPreferences.getString(_post);
  String? company() => _sharedPreferences.getString(_company);
  String? idCard() => _sharedPreferences.getString(_idCard);
  String? dictData() => _sharedPreferences.getString(_dictData);

  setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(_isUserLogin, isLogin);
  }

  setToken(String token) async {
    if (token != null) {
      await _sharedPreferences.setString(_userToken, token);
    }
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

  setPhone(String phone) async {
    await _sharedPreferences.setString(_phone, phone);
  }

  setPost(String post) async {
    await _sharedPreferences.setString(_post, post);
  }

  setCompany(String company) async {
    await _sharedPreferences.setString(_company, company);
  }

  setIdCard(String idCard) async {
    await _sharedPreferences.setString(_idCard, idCard);
  }

  setDictData(String dictData) async {
    await _sharedPreferences.setString(_dictData, dictData);
  }
}
