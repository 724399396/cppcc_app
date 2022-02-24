import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:dio/dio.dart';

import 'local_data_provider.dart';

class ApiDataProvider {
  final Dio _dio;
  final LocalDataProvider _localDataProvider;
  final NavigationService _navigationService;
  int _lastErrorTimestamp = 0;

  ApiDataProvider(this._dio, this._localDataProvider, this._navigationService) {
    // TODO remove on production
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['X-Access-Token'] = _localDataProvider.token();
      return handler.next(options);
    }, onResponse: (response, handler) {
      if (response.statusCode != 200) {
        handler.reject(
            DioError(error: '网络错误', requestOptions: response.requestOptions));
      }
      if (!response.data['success']) {
        return handler.reject(DioError(
            error: response.data['message'],
            requestOptions: response.requestOptions));
      }
      return handler.next(response);
    }, onError: (e, handler) {
      var currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      if (e.response != null && e.response?.data['message'] != null) {
        if (e.response?.data['message'] == 'Token失效，请重新登录') {
          if (!e.requestOptions.extra.containsKey('dontRedirectLogin') ||
              !e.requestOptions.extra['dontRedirectLogin']) {
            showToast(e.response?.data['message']);
            _localDataProvider.setIsLogin(false);
            _navigationService.pushNamedAndRemoveUntil(Routes.loginPage);
          }
        } else {
          showToast(e.response?.data['message']);
        }
      } else if (e.error != null) {
        if (currentTimestamp - _lastErrorTimestamp > 1000 * 5) {
          showToast('网络错误');
        }
      } else {
        if (currentTimestamp - _lastErrorTimestamp > 1000 * 5) {
          showToast('网络错误');
        }
      }
      _lastErrorTimestamp = currentTimestamp;
      return handler.next(e);
    }));
  }

  Future<LoginResponse> login(String email, String password) {
    return _dio.post('/sys/mLogin', data: {
      'username': email,
      'password': password
    }).then((value) => LoginResponse.fromJson(
        BaseResponse.fromJson(value.data).result as Map<String, dynamic>));
  }

  Future<Response<void>> modifyPassword(
      String oldPassword, String newPassword) {
    return _dio.put('', data: {
      'oldpassword': oldPassword,
      'password': newPassword,
      'confirmpassword': newPassword
    });
  }

  Future<Response<void>> resetPassword(String password) {
    return _dio.get('', queryParameters: {
      'password': password,
    });
  }
}
