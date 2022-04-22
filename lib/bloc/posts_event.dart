part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostInitilized extends PostsEvent {}

class PostFirstFetch extends PostsEvent {
  final PostKey key;

  const PostFirstFetch(this.key);
}

class PostRefresh extends PostsEvent {
  final PostKey key;

  const PostRefresh(this.key);
}

class PostLoadMore extends PostsEvent {
  final PostKey key;

  const PostLoadMore(this.key);
}

class PostReaded extends PostsEvent {
  final Posts posts;

  const PostReaded(this.posts);
}
