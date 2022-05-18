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

class DiscussNetworkFirstFetch extends DiscussNetworkEvent {
  final DiscussNetworkListType type;

  const DiscussNetworkFirstFetch(this.type);
}

class GoDiscussNetworkDetail extends DiscussNetworkEvent {
  final DiscussNetwork discussNetwork;

  const GoDiscussNetworkDetail(this.discussNetwork);
}

class DicusssNetworkMsgLike extends DiscussNetworkEvent {
  final String id;
  final int type;
  final SuccessCallback successCallback;

  const DicusssNetworkMsgLike(this.id, this.type, this.successCallback);
}

class DicusssNetworkMsgSend extends DiscussNetworkEvent {
  final DiscussMessageSendRequest request;
  final SuccessCallback successCallback;

  const DicusssNetworkMsgSend(this.request, this.successCallback);
}

class DiscussNetowrkChanged extends DiscussNetworkEvent {
  final DiscussNetworkChangeResponse change;

  const DiscussNetowrkChanged(this.change);
}
