import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:cppcc_app/utils/routes.dart';

class PostsItem extends StatelessWidget {
  final Posts _post;
  const PostsItem(this._post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: GestureDetector(
      onTap: () {
        switch (_post.postType) {
          case PostType.news:
            Navigator.of(context)
                .pushNamed(Routes.newsDetailsPage, arguments: _post);
            break;
          case PostType.broadcast:
            // TODO: Handle this case.
            break;
          case PostType.twoSessionsTopic:
            // TODO: Handle this case.
            break;
          case PostType.discussPoliticsFile:
            // TODO: Handle this case.
            break;
          case PostType.learning:
            // TODO: Handle this case.
            break;
          case PostType.fileAnnment:
            // TODO: Handle this case.
            break;
          case PostType.gdHistory:
            // TODO: Handle this case.
            break;
          case PostType.unknown:
            // TODO: Handle this case.
            break;
        }
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xfff4f4f4)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFc6c3bc),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: Text(
                          _post.categoryDictText != null
                              ? _post.categoryDictText!
                              : _post.postType.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timeago.format(_post.createTime, locale: 'zh'),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.greyTextColor),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _post.hits.toString() + '阅读',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.greyTextColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: _post.cover == null
                      ? Image.asset('assets/icons/ic_news.png')
                      : CachedNetworkImage(
                          imageUrl: _post.cover!,
                          fit: BoxFit.cover,
                        )),
            ),
          ],
        ),
      ),
    ));
  }
}
