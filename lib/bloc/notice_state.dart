part of 'notice_bloc.dart';

class NoticeState extends Equatable {
  final int unreadCount;
  const NoticeState({
    this.unreadCount = 0,
  });

  @override
  List<Object> get props => [unreadCount];

  NoticeState copyWith({
    int? unreadCount,
  }) {
    return NoticeState(
     unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  String toString() => 'NoticeState(unreadCount: $unreadCount)';
}
