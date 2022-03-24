part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final List<Posts> news;

  ///会议播报
  final List<Posts> broadcasts;

  ///两会专题
  final List<Posts> twoSessionsTopics;

  ///议政文件
  final List<Posts> discussPoliticsFiles;

  ///委员学习
  final List<Posts> learnings;

  ///官渡文史
  final List<Posts> gdHistory;

  final List<Posts> fileAnnments;
  final ListDataFetchStatus status;
  final int homeCurrentPage;

  const PostsState({
    this.news = const [],
    this.broadcasts = const [],
    this.twoSessionsTopics = const [],
    this.discussPoliticsFiles = const [],
    this.learnings = const [],
    this.fileAnnments = const [],
    this.gdHistory = const [],
    this.status = ListDataFetchStatus.normal,
    this.homeCurrentPage = 1,
  });

  @override
  List<Object> get props => [
        news,
        broadcasts,
        twoSessionsTopics,
        discussPoliticsFiles,
        learnings,
        fileAnnments,
        gdHistory,
        status,
        homeCurrentPage
      ];

  PostsState copyWith({
    List<Posts>? news,
    List<Posts>? broadcasts,
    List<Posts>? twoSessionsTopics,
    List<Posts>? discussPoliticsFiles,
    List<Posts>? learnings,
    List<Posts>? fileAnnments,
    List<Posts>? gdHistory,
    ListDataFetchStatus? status,
    int? homeCurrentPage,
  }) {
    return PostsState(
      news: news ?? this.news,
      broadcasts: broadcasts ?? this.broadcasts,
      twoSessionsTopics: twoSessionsTopics ?? this.twoSessionsTopics,
      discussPoliticsFiles: discussPoliticsFiles ?? this.discussPoliticsFiles,
      learnings: learnings ?? this.learnings,
      fileAnnments: fileAnnments ?? this.fileAnnments,
      gdHistory: gdHistory ?? this.gdHistory,
      status: status ?? this.status,
      homeCurrentPage: homeCurrentPage ?? this.homeCurrentPage,
    );
  }

  @override
  String toString() {
    return 'PostsState(news: $news, broadcasts: $broadcasts, twoSessionsTopics: $twoSessionsTopics, discussPoliticsFiles: $discussPoliticsFiles, learnings: $learnings, fileAnnments: $fileAnnments, gdHistory: $gdHistory, status: $status, homeCurrentPage: $homeCurrentPage)';
  }
}
