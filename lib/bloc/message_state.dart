part of 'message_bloc.dart';

class MessageState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<MessageRecords> listDatas;

  // final SuccessCallback? successCallback;

  MessageState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  MessageState copyWith(
    int pageNo,
    MessageEntity result,
  ) {
    print("pageNo===========================" + pageNo.toString());
    return MessageState(
      pageNo: pageNo,
      pageSize: result.size,
      total: result.total,
      listDatas: result.records,
    );
  }

  @override
  List<Object> get props {
    return [
      pageNo,
      pageSize,
      total,
      listDatas,
    ];
  }
}

// class MessageEntityState extends Equatable {
//   final MessageRecords? entity = MessageRecords();
//
//   MessageEntityState({
//     this.entity,
//   });
//
//   MessageEntityState copyWith(
//     MessageRecords result,
//   ) {
//     return MessageEntityState(
//       entity: result,
//     );
//   }
//
//   @override
//   List<Object> get props {
//     return [entity];
//   }
// }
