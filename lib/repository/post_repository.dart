import 'package:cppcc_app/dto/posts_response.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class PostRepository {
  final ApiDataProvider _apiDataProvider;

  PostRepository(this._apiDataProvider);

  Future<List<Posts>> getPostList(
      int page, int pageSize, PostType postType, int? category) async {
    return _apiDataProvider
        .getPostList(page, pageSize, postType, category)
        .then((response) {
      return response.records
          .map(
            (PostsResponse p) => Posts(
                id: p.id,
                postType: convertToPostTypeFromCode(p.type!),
                title: p.title,
                author: p.author,
                content: p.content,
                category: p.category,
                cover: p.cover,
                hits: p.hits,
                appendix: p.appendix,
                createBy: p.createBy,
                createTime: DateTime.parse(p.createTime),
                categoryDictText: p.categoryDictText,
                read: p.read ?? false),
          )
          .toList();
    });
  }

  Future<int> getFileAnnounmentUnreadCount() {
    return _apiDataProvider.getFileAnnounmentUnreadCount();
  }

  Future<int> getLearningUnreadCount() {
    return _apiDataProvider.getLearningUnreadCount();
  }

  Future<int> getGdHistoryUnreadCount() {
    return _apiDataProvider.getGdHistoryUnreadCount();
  }

  Future getPostsDetail(String id) {
    return _apiDataProvider.getPostsDetail(id);
  }
}
