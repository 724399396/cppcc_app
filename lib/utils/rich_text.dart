import 'package:delta_markdown/delta_markdown.dart';
import 'dart:convert';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_quill/flutter_quill.dart' as quill;

String quillDeltaToHtml(quill.Delta delta) {
  final convertedValue = jsonEncode(delta.toJson());
  final markdown = deltaToMarkdown(convertedValue);
  final html = md.markdownToHtml(markdown);
  return html;
}
