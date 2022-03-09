
part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final List<Posts> news;
  final List<Posts> fileAnnments;
  final ListDataFetchStatus status;
  final int homeCurrentPage;
  const PostsState({
    this.news = const [],
    this.fileAnnments = const [],
    this.status = ListDataFetchStatus.normal,
    this.homeCurrentPage = 1,
  });

  @override
  List<Object> get props => [news, fileAnnments, status, homeCurrentPage];

  PostsState copyWith({
    List<Posts>? news,
    List<Posts>? fileAnnments,
    ListDataFetchStatus? status,
    int? homeCurrentPage,
  }) {
    return PostsState(
      news: news ?? this.news,
      fileAnnments: fileAnnments ?? this.fileAnnments,
      status: status ?? this.status,
      homeCurrentPage: homeCurrentPage ?? this.homeCurrentPage,
    );
  }

  @override
  String toString() {
    return 'PostsState(news: $news, fileAnnments: $fileAnnments, status: $status, homeCurrentPage: $homeCurrentPage)';
  }
}
