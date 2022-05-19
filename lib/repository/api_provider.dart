import 'dart:typed_data';

import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/dto/dict_response.dart';
import 'package:cppcc_app/dto/discuss_network_request.dart';
import 'package:cppcc_app/dto/discuss_network_response.dart';
import 'package:cppcc_app/dto/file_response.dart';
import 'package:cppcc_app/dto/historical_clue_response.dart';
import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/dto/mailbox_request.dart';
import 'package:cppcc_app/dto/mailbox_response.dart';
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:cppcc_app/dto/message_response.dart';
import 'package:cppcc_app/dto/message_type.dart';
import 'package:cppcc_app/dto/opinion_request.dart';
import 'package:cppcc_app/dto/opinion_response.dart';
import 'package:cppcc_app/dto/posts_response.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/dto/proposal_request.dart';
import 'package:cppcc_app/dto/proposal_response.dart';
import 'package:cppcc_app/dto/two_meetings_response.dart';
import 'package:cppcc_app/models/guandu_historical_clue.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:dio/dio.dart';

import 'local_data_provider.dart';

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

  Future<Response<void>> modifyPassword(String newPassword) {
    return _dio
        .post('/app/user/updatePassword', data: {'password': newPassword});
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
  Future<List<SystemMessageResponse>> getSystemMessageList(
      int pageNo, int pageSize, MessageType type) {
    return _dio.get('/sys/annountCement/app/list', queryParameters: {
      'pageNo': pageNo,
      'pageSize': pageSize,
      'msgCategory': type.code
    }).then((value) {
      return SystemMessageResponse.fromJsonList(
          BaseResponse.fromJson(value.data).result as List<dynamic>);
    });
  }

  /// 获取领导信箱
  Future<List<MailboxResponse>> getMailBoxList(
      int pageNo, int pageSize, String mailboxType) {
    return _dio.post('/app/mailbox/appGetList', data: {
      'pageNo': pageNo,
      'pageSize': pageSize,
      "mailboxType": int.tryParse(mailboxType)
    }).then((value) {
      return MailboxResponse.fromJsonList(
          BaseResponse.fromJson(value.data).result as List<dynamic>);
    });
  }

  /// 添加领导信箱
  Future<BaseResponse> addMailbox(AddMailRequest request) {
    return _dio.post('/app/mailbox/add', data: request.toJson()).then((value) {
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
  Future<BaseResponse> addHistoricalClue(GuanduHistoricalClue clue) {
    return _dio.post('/app/historicalClue/add', data: {
      "title": clue.title,
      "unit": clue.unit,
      "provider": clue.provider,
      "phone": clue.phone,
      "content": clue.content
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

  Future<PostsResponse> getPostsDetail(String id) {
    return _dio.get('/app/posts/queryById/app', queryParameters: {
      'id': id,
    }).then((value) => PostsResponse.fromJson(
        BaseResponse.fromJson(value.data).result as Map<String, dynamic>));
  }

  Future<int> getAnnouncementUnreadCount(MessageType type) {
    return _dio.get('/sys/annountCement/app/unreadCount', queryParameters: {
      'msgCategory': type.code,
    }).then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<int> getBusinessCardUnreadCount() {
    return _dio
        .get('/app/buscardApply/count/num')
        .then((value) => BaseResponse.fromJson(value.data).result as int);
  }

  Future<List<BusinessCardMessageResponse>> getBusinessCardMessageList(
      int pageNo, int pageSize) {
    return _dio.post('/app/buscardApply/appGetList', data: {
      'pageNo': pageNo,
      'pageSize': pageSize,
    }).then((value) {
      return BusinessCardMessageResponse.fromJsonList(
          BaseResponse.fromJson(value.data).result as List<dynamic>);
    });
  }

  Future<BaseResponse> readAnnouncementMessage(String id) {
    return _dio.put('/sys/sysAnnouncementSend/editByAnntIdAndUserId', data: {
      'anntId': id,
    }).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  Future getBusinessCardDetail(String id) {
    // TODO
    return Future.value(null);
  }

  Future<BaseResponse> get(String uri) {
    return _dio.get(uri).then((value) => BaseResponse.fromJson(value.data));
  }

  Future<FileResponse> upload(Uint8List dataBytes, String name) async {
    var formData = FormData.fromMap({
      'biz': 'mobile',
      'file': MultipartFile.fromBytes(dataBytes, filename: name)
    });
    return _dio.post('/sys/upload/uploadMinio', data: formData).then((value) =>
        FileResponse.fromJson(
            BaseResponse.fromJson(value.data).result as Map<String, dynamic>));
  }

  Future<BaseResponse> updateUserInfo(UserUpdateRequest userUpdateRequest) {
    return _dio
        .put('/sys/user/appEdit', data: userUpdateRequest.toJson())
        .then((value) => BaseResponse.fromJson(value.data));
  }

  Future<BaseResponse> updatePhone(String phone, String verifyCode) {
    return _dio.post('/app/user/updatePhone', data: {
      'phone': phone,
      'verifyCode': verifyCode,
    }).then((value) => BaseResponse.fromJson(value.data));
  }

  Future<BaseResponse> addOpinion(OpinionAddRequest opinion) {
    return _dio.post('/app/opinion/add', data: opinion.toJson()).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  Future<OpinionResponse> getOpinionDetail(id) {
    return _dio.get('/app/opinion/queryById/app', queryParameters: {
      'id': id,
    }).then((value) {
      return OpinionResponse.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  Future<List<OpinionProgressResponse>> getOpinionProgress(String id) {
    return _dio.get('/app/opinionProgress/list',
        queryParameters: {'opinionId': id}).then((value) {
      return OpinionProgressResponse.fromJsonList(
          ((BaseResponse.fromJson(value.data).result
              as Map<String, dynamic>)['records'] as List<dynamic>));
    });
  }

  Future<List<ProposalResponse>> getProposalList(
      int page, int pageSize, bool? excellent) {
    return _dio.post('/app/proposal/appGetList', data: {
      'pageNo': page,
      'pageSize': pageSize,
      'excellent': excellent,
    }).then((value) {
      return ProposalResponse.fromJsonList(
          BaseResponse.fromJson(value.data).result as List<dynamic>);
    });
  }

  Future addProposal(ProposalAddRequest request) {
    return _dio.post('/app/proposal/add', data: request.toJson()).then((value) {
      return BaseResponse.fromJson(value.data);
    });
  }

  Future<ProposalResponse> getProposalDetail(String id) {
    return _dio.get('/app/proposal/queryById/app', queryParameters: {
      'id': id,
    }).then((value) {
      return ProposalResponse.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  Future<List<ProposalProgressResponse>> getProposalProgress(String id) {
    return _dio.get('/app/proposalProgress/list',
        queryParameters: {'proposalId': id}).then((value) {
      return ProposalProgressResponse.fromJsonList(
          ((BaseResponse.fromJson(value.data).result
              as Map<String, dynamic>)['records'] as List<dynamic>));
    });
  }

  Future<DiscussNetworkResponse> getDiscussNetworkDetail(String id) {
    return _dio.get('/app/discussNetwork/queryById/app', queryParameters: {
      'id': id,
    }).then((value) {
      return DiscussNetworkResponse.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }

  Future userLikeDiscussNetwork(String id, int type) {
    return _dio.post('/app/discussNetworkMsg/userLike', data: {
      'sourceId': id,
      'type': type,
    }).then((value) => BaseResponse.fromJson(value.data).result);
  }

  Future dicusssNetworkMsgSend(DiscussMessageSendRequest request) {
    return _dio
        .post('/app/discussNetworkMsg/add', data: request.toJson())
        .then((value) => BaseResponse.fromJson(value.data).result);
  }

  Future<MailboxResponse> getMailDetail(String id) {
    return _dio.get('/app/mailbox/queryById/app', queryParameters: {
      'id': id,
    }).then((value) {
      return MailboxResponse.fromJson(
          BaseResponse.fromJson(value.data).result as Map<String, dynamic>);
    });
  }
}
