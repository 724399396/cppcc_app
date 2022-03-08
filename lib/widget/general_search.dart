import 'package:flutter/material.dart';

class GeneralSearch extends StatelessWidget {
  const GeneralSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const ValueKey('keyword'),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(
              color: Colors.white, width: 0.0, style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(
              color: Colors.white, width: 0.0, style: BorderStyle.solid),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Colors.white,
            ),
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Image.asset(
            'assets/icons/ic_search.png',
            color: Colors.white,
          ),
          width: 28,
          height: 28,
        ),
        hintText: '请输入关键词',
      ),
      onSubmitted: (value) {
        _search(context);
      },
      textInputAction: TextInputAction.search,
    );
  }

  void _search(context) {}
}
