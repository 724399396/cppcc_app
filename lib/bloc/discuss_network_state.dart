part of 'discuss_network_bloc.dart';

class DiscussNetworkState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<DiscussNetworkListType, List<DiscussNetwork>> data;
  final Map<DiscussNetworkListType, int> currentPage;
  const DiscussNetworkState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.data = const {},
    this.currentPage = const {},
  });

  DiscussNetworkState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<DiscussNetworkListType, List<DiscussNetwork>>? data,
    Map<DiscussNetworkListType, int>? currentPage,
  }) {
    return DiscussNetworkState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'DiscussNetworkState(unreadCount: $unreadCount, status: $status, data: $data, currentPage: $currentPage)';
  }

  @override
  List<Object> get props => [unreadCount, status, data, currentPage];
}
