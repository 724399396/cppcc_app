part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostInitilized extends PostsEvent {}

class PostRefresh extends PostsEvent {
  final PostKey key;

  const PostRefresh(this.key);

}

class PostLoadMore extends PostsEvent {
  final PostKey key;

  const PostLoadMore(this.key);

}
