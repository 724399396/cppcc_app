import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/dto/dict_response.dart';
import 'package:cppcc_app/dto/discuss_network_response.dart';
import 'package:cppcc_app/dto/historical_clue_response.dart';
import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/dto/mailbox_response.dart';
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:cppcc_app/dto/opinion_response.dart';
import 'package:cppcc_app/dto/posts_response.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/dto/two_meetings_response.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:dio/dio.dart';

import 'local_data_provider.dart';

//消息
import 'package:cppcc_app/dto/message/message_entity.dart';

//资讯

class ApiDataProvider {
  final Dio _dio;
  final LocalDataProvider _localDataProvider;
  final NavigationService _navigationService;
  int _lastErrorTimestamp = 0;

  ApiDataProvider(this._dio, this._localDataProvider, this._navigationService) {
    // TODO remove on production
    // _dio.interceptors
    //     .add(LogInterceptor(responseBody: true, requestBody: true));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['X-Access-Token'] = _localDataProvider.token();
      return handler.next(options);
    }, onResponse: (response, handler) {
      if (response.statusCode != 200) {
        handler.reject(
            DioError(error: '网络错误', requestOptions: response.requestOptions));
      }
      if (!response.data['success']) {
        showToast(response.data['message']);
        return handler.reject(DioError(
            error: response.data['message'],
            requestOptions: response.requestOptions));
      }
      return handler.next(response);
    }, onError: (e, handler) {
      var currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      if (currentTimestamp - _lastErrorTimestamp > 1000 * 5) {
        if (e.response != null && e.response?.data['code'] != null) {
          if (e.response?.data['code'] == 401) {
            showToast(e.response?.data['message']);
            _localDataProvider.setIsLogin(false);
            _navigationService.pushNamedAndRemoveUntil(Routes.loginPage);
          } else {
            showToast(e.response?.data['message']);
          }
        } else {
          showToast('网络错误');
        }
      }
      _lastErrorTimestamp = currentTimestamp;
      return handler.next(e);
    }));
  }

  Future<LoginResponse> login(String phone, String password) {
    return _dio.post('/app/user/login',
        data: {'phone': phone, 'password': password}).then((value) {
      return LoginResponse.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  Future<Response<void>> modifyPassword(
      String oldPassword, String newPassword) {
    return _dio.put('', data: {
      'oldpassword': oldPassword,
      'password': newPassword,
      'confirmpassword': newPassword
    });
  }

  Future<Response<void>> resetPassword(
      String phone, String password, String verifyCode) {
    return _dio.post('/app/user/resetPassword',
        data: {'phone': phone, 'password': password, 'verifyCode': verifyCode});
  }

  Future<UserInfoResponse> getUserInfo() {
    return _dio.get('/app/user/info').then((value) => UserInfoResponse.fromJson(
        BaseResponse.fromJson(value.data).result as Map<String, dynamic>));
  }

  Future<Response<void>> sendSmsVerifyCode(String phone) {
    return _dio.post('/app/user/sendSmsVerifyCode', data: {'phone': phone});
  }

  /// 获取消息
  Future<MessageEntity> getMassage(
      int pageNo, int pageSize, String msgCategory) {
    return _dio.get('/sys/sysAnnouncementSend/getMyAnnouncementSend',
        queryParameters: {
          'pageNo': pageNo,
          'pageSize': pageSize,
          'msgCategory': msgCategory
        }).then((value) {
      return MessageEntity.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  /// 获取消息详情
  Future<MessageRecords> getMassageInfo(String id) {
    return _dio.get('/sys/sysAnnouncementSend/getMyAnnouncementSend',
        queryParameters: {'id': id}).then((value) {
      return MessageRecords.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  /// 获取领导信箱
  Future<MailboxResponseWrapper> getMailBoxList(
      int pageNo, int pageSize, String mailboxType) {
    return _dio.get('/app/mailbox/list', queryParameters: {
      'pageNo': pageNo,
      'pageSize': pageSize,
      "type": mailboxType
    }).then((value) {
      return MailboxResponseWrapper.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  /// 添加领导信箱
  Future<BaseResponse> addMailbox(
      String type, String userId, String phone, String title, String content) {
    return _dio.post('/app/mailbox/add', data: {
      "type": type,
      "userId": userId,
      "phone": phone,
      "title": title,
      "content": content
    }).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  /// 线索征集
  Future<HistoricalClueWrapper> getHistoricalClueList(
      int pageNo, int pageSize) {
    return _dio.get('/app/historicalClue/list', queryParameters: {
      'pageNo': pageNo,
      'pageSize': pageSize
    }).then((value) {
      return HistoricalClueWrapper.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  /// 添加线索征集
  Future<BaseResponse> addHistoricalClue(String title, String unit,
      String provider, String phone, String content) {
    return _dio.post('/app/historicalClue/add', data: {
      "title": title,
      "unit": unit,
      "provider": provider,
      "phone": phone,
      "content": content
    }).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  /// 获取会议列表
  Future<List<MeetingResponse>> getMeetingList(
      int pageNo, int pageSize, String type) {
    return _dio.post('/app/meetingActivity/appGetList', data: {
      'pageNo': pageNo,
      'pageSize': pageSize,
      "type": type
    }).then((value) {
      return MeetingResponse.fromJsonList(
          BaseResponse.fromJson(value.data).result as List<dynamic>);
    });
  }

  /// 获取网络议政列表
  Future<List<DiscussNetworkResponse>> getDiscussNetworkList(
      int pageNo, int pageSize, List<int> status) {
    return _dio.post('/app/discussNetwork/appGetList', data: {
      'pageNo': pageNo,
      'pageSize': pageSize,
      "status": status
    }).then((value) {
      return DiscussNetworkResponse.fromJsonList(
          BaseResponse.fromJson(value.data).result as List<dynamic>);
    });
  }

  Future<PostsResponseWrapper> getPostList(
      int page, int pageSize, PostType postType, int? category) {
    return _dio.get('/app/posts/list', queryParameters: {
      'pageNo': page,
      'pageSize': pageSize,
      'type': postType.code,
      'category': category
    }).then((value) => PostsResponseWrapper.fromJson(
        BaseResponse.fromJson(value.data).result as Map<String, dynamic>));
  }

  Future<List<DictResponse>> getDict() {
    return _dio.get('/sys/dict/getDictForApp').then((value) =>
        DictResponse.fromJsonList(
            BaseResponse.fromJson(value.data).result as List<dynamic>));
  }

  Future<List<OpinionResponse>> getOpinionsList(
      int page, int pageSize, List<int> status) {
    return _dio.post('/app/opinion/appGetList', data: {
      'pageNo': page,
      'pageSize': pageSize,
      'status': status,
    }).then((value) => OpinionResponse.fromJsonList(
        BaseResponse.fromJson(value.data).result as List<dynamic>));
  }

  Future<int> getOpinionUnreadCount() {
    return _dio
        .get('/app/opinion/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getProposalUnreadCount() {
    return _dio
        .get('/app/proposal/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getMeetingUnreadCount() {
    return _dio
        .get('/app/meetingActivity/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getNoticeUnreadCount() {
    return _dio
        .get('/sys/sysAnnouncementSend/count/num')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getFileAnnounmentUnreadCount() {
    return _dio
        .get('/app/fileAnnment/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getDiscussNetworkUnreadCount() {
    return _dio
        .get('/app/discussNetwork/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getLearningUnreadCount() {
    return _dio
        .get('/app/learning/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getMailboxUnreadCount() {
    return _dio
        .get('/app/mailbox/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getGdHistoryUnreadCount() {
    return _dio
        .get('/app/historicalDatum/count/read/app')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<List<UserResponse>> getAllContact() {
    return _dio.get('/app/user/all').then((value) => UserResponse.fromJsonList(
        BaseResponse.fromJson(value.data).result as List<dynamic>));
  }

  Future sendBusinessCard(String receiverUsername, String message) {
    return _dio.post('/app/buscardApply/appApply', data: {
      'receiveUsername': receiverUsername,
      'message': message
    }).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  Future<TwoMeetingsWrapper> getTwoMeetingsList(int pageNo, int pageSize) {
    return _dio.get('/app/commonFile/list', queryParameters: {
      'pageNo': pageNo,
      'pageSize': pageSize,
    }).then((value) {
      return TwoMeetingsWrapper.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  Future<MeetingDetailResponse> getMeetingDetail(String id) {
    return _dio.get('/app/meetingActivity/queryById/app', queryParameters: {
      'id': id,
    }).then((value) {
      return MeetingDetailResponse.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  Future<BaseResponse> applyLeaveMeeting(String meetingId, String userId) {
    return _dio.post('/app/meetingActivityRecord/leaveMeetActivity', data: {
      'mettingActivityId': meetingId,
      'userId': userId,
    }).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  Future getPostsDetail(String id) {
    return _dio.get('/app/posts/queryById/app', queryParameters: {
      'id': id,
    }).then((value) => BaseResponse.fromJson(value.data));
  }
}
