part of 'discuss_network_bloc.dart';

class DiscussNetworkState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<DiscussNetworkListType, List<DiscussNetwork>> data;
  final Map<DiscussNetworkListType, int> currentPage;
  final DiscussNetwork? currentDiscuss;
  final FormStatus? submitStatus;
  const DiscussNetworkState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.data = const {},
    this.currentPage = const {},
    this.currentDiscuss,
    this.submitStatus,
  });

  DiscussNetworkState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<DiscussNetworkListType, List<DiscussNetwork>>? data,
    Map<DiscussNetworkListType, int>? currentPage,
    DiscussNetwork? currentDiscuss,
    FormStatus? submitStatus,
  }) {
    return DiscussNetworkState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      currentDiscuss: currentDiscuss ?? this.currentDiscuss,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }

  @override
  String toString() {
    return 'DiscussNetworkState(unreadCount: $unreadCount, status: $status, data: $data, currentPage: $currentPage, submitStatus: $submitStatus)';
  }

  @override
  List<Object> get props {
    return [
      unreadCount,
      status,
      data,
      currentPage,
      currentDiscuss ?? '',
      submitStatus ?? '',
    ];
  }
}
