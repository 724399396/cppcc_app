part of 'posts_bloc.dart';

class PostKey extends Equatable {
  final PostType type;
  final int? category;

  const PostKey(
    this.type,
    this.category,
  );

  PostKey copyWith({
    PostType? type,
    int? category,
  }) {
    return PostKey(
      type ?? this.type,
      category ?? this.category,
    );
  }

  @override
  String toString() => 'PostKey(type: $type, category: $category)';

  @override
  List<Object> get props => [type, category ?? -1];
}

class PostsState extends Equatable {
  final ListDataFetchStatus status;
  final Map<PostKey, List<Posts>> posts;
  final Map<PostKey, int> currentPage;
  final Map<PostType, int> unreadCount;

  const PostsState({
    this.status = ListDataFetchStatus.normal,
    this.posts = const {},
    this.currentPage = const {},
    this.unreadCount = const {},
  });

  @override
  List<Object> get props => [status, posts, currentPage, unreadCount];

  PostsState copyWith({
    ListDataFetchStatus? status,
    Map<PostKey, List<Posts>>? posts,
    Map<PostKey, int>? currentPage,
    Map<PostType, int>? unreadCount,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  String toString() {
    return 'PostsState(status: $status, posts: $posts, currentPage: $currentPage, unreadCount: $unreadCount)';
  }
}
