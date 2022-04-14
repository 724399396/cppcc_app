part of 'discuss_network_bloc.dart';

abstract class DiscussNetworkEvent extends Equatable {
  const DiscussNetworkEvent();

  @override
  List<Object> get props => [];
}

class DiscussNetworkInitilized extends DiscussNetworkEvent {}


class DiscussNetworkLoadMore extends DiscussNetworkEvent {
  final DiscussNetworkListType type;

  const DiscussNetworkLoadMore(this.type);
}

class DiscussNetworkRefresh extends DiscussNetworkEvent {
  final DiscussNetworkListType type;

  const DiscussNetworkRefresh(this.type);
}
