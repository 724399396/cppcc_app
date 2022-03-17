part of 'discuss_network_bloc.dart';

abstract class DiscussNetworkEvent extends Equatable {
  const DiscussNetworkEvent();

  @override
  List<Object> get props => [];
}

class GetDiscussNetworkData extends DiscussNetworkEvent {
  final int pageNo;
  final int pageSize;
  final String status;

  const GetDiscussNetworkData(this.pageNo, this.pageSize, this.status)
      : super();

  @override
  List<Object> get props => [pageNo, pageSize, status];
}
