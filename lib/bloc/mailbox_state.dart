part of 'mailbox_bloc.dart';

class MailboxState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<MailboxResponse> listDatas;

  const MailboxState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  MailboxState copyWith(
    int pageNo,
    MailboxResponseWrapper result,
  ) {
    return MailboxState(
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
