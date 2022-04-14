import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_list_container.dart';
import 'package:flutter/material.dart';

class PostsWithFilterArgument {
  final PostKey postKey;
  final String title;

  PostsWithFilterArgument(this.postKey, this.title);
}

class PostsListWithFilterPage extends StatelessWidget {
  const PostsListWithFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var argument =
        ModalRoute.of(context)?.settings.arguments as PostsWithFilterArgument;
    return Scaffold(
      appBar: AppBar(title: Text(argument.title)),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(children: [
          GeneralSearch(AppColors.greyTextColor, ((context, keyword) => {})),
          Expanded(child: PostsListContainer(argument.postKey)),
        ]),
      ),
    );
  }
}
