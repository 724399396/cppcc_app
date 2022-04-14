import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:flutter/material.dart';

// TODO replace real search
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyword = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "搜索结果",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            GeneralSearch(
              AppColors.greyTextColor,
              ((context, keyword) => {}),
              initValue: keyword,
            ),
          ],
        ),
      ),
    );
  }
}
