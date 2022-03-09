part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostInitilized extends PostsEvent {}

class HomePostRefresh extends PostsEvent {}

class HomePostLoadMore extends PostsEvent {}
