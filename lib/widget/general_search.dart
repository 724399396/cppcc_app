import 'package:flutter/material.dart';

typedef SearchCallback = void Function(BuildContext context, String keyword);

class GeneralSearch extends StatelessWidget {
  final Color _color;
  final SearchCallback _callback;
  final String? initValue;
  final String hint;
  final Color? fillColor;
  const GeneralSearch(this._color, this._callback,
      {Key? key, this.initValue, this.hint = '请输入关键字', this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const ValueKey('keyword'),
      controller: TextEditingController(text: initValue ?? ''),
      decoration: InputDecoration(
        filled: fillColor != null,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          borderSide:
              BorderSide(color: _color, width: 0.0, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          borderSide:
              BorderSide(color: _color, width: 0.0, style: BorderStyle.solid),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: _color,
            ),
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Image.asset(
            'assets/icons/ic_search.png',
            color: _color,
          ),
          width: 28,
          height: 28,
        ),
        hintText: hint,
      ),
      style: TextStyle(color: _color),
      onSubmitted: (value) {
        _callback(context, value);
      },
      textInputAction: TextInputAction.search,
    );
  }
}
