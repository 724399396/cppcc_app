import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  String _keyword = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Container(
          color: AppColors.primary,
          height: 36,
        ),
        Positioned(
          top: 36,
          child: SizedBox(
            child: Image.asset(
              'assets/bg/bg_news.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 56, 16, 16),
          child: GeneralSearch(
            Colors.white,
            ((context, keyword) => {
                  setState(() {
                    _keyword = keyword;
                  })
                }),
            initValue: _keyword,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 116),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.background,
            child: BlocEasyFrefresh<PostsBloc, PostsState, Posts>(
                (state) =>
                    (state.posts[const PostKey(PostType.news, null)] ?? [])
                        .where((element) => element.title.contains(_keyword))
                        .toList(), () async {
              BlocProvider.of<PostsBloc>(context)
                  .add(const PostLoadMore(PostKey(PostType.news, null)));
            }, () async {
              BlocProvider.of<PostsBloc>(context)
                  .add(const PostRefresh(PostKey(PostType.news, null)));
            }, (p) => PostsItem(p))),
      ],
    ));
  }
}
