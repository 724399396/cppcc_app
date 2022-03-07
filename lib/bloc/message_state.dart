part of 'message_bloc.dart';

class MessageState extends Equatable {
  @override
  List<Object> get props => [];

  final int pageNo;
  final int pageSize;
  final int total;
  final List<MessageRecords> listDatas;

  // final SuccessCallback? successCallback;

  MessageState({
    this.pageNo = 1,
    this.pageSize = 1,
    this.total = 0,
    this.listDatas = const [],
  });

  MessageState copyWith(
    int pageNo,
    MessageEntity result,
  ) {
    return MessageState(
      pageNo: pageNo,
      pageSize: result.size,
      total: result.total,
      listDatas: result.records,
    );
  }
}
