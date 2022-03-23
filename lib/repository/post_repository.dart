import 'package:cppcc_app/dto/posts_response.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class PostRepository {
  final ApiDataProvider _apiDataProvider;

  PostRepository(this._apiDataProvider);

  Future<List<Posts>> getPostList(
      int page, int pageSize, PostType postType) async {
    return _apiDataProvider
        .getPostList(page, pageSize, postType)
        .then((response) {
      return response.records
          .map((PostsResponse p) => Posts(
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
              ))
          .toList();
    });
  }
}
