import 'package:cppcc_app/repository/upload_repository.dart';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_quill/flutter_quill.dart' as quill;

String quillDeltaToHtml(quill.Delta delta) {
  final convertedValue = jsonEncode(delta.toJson());
  final markdown = deltaToMarkdown(convertedValue);
  final html = md.markdownToHtml(markdown);
  return html;
}

Widget quillEditor(
    BuildContext context, quill.QuillController _contentController) {
  return Column(
    children: [
      quill.QuillToolbar.basic(
        controller: _contentController,
        locale: const Locale('zh', 'CN'),
        showDividers: false,
        showFontSize: false,
        showUnderLineButton: false,
        showStrikeThrough: false,
        showInlineCode: false,
        showColorButton: false,
        showBackgroundColorButton: false,
        showLeftAlignment: false,
        showCenterAlignment: false,
        showRightAlignment: false,
        showJustifyAlignment: false,
        showListCheck: false,
        showVideoButton: false,
        showCameraButton: false,
        onImagePickCallback: (file) async {
          var url = await RepositoryProvider.of<UploadRepository>(context)
              .upload(file);
          return url;
        },
        mediaPickSettingSelector: (context) async {
          return quill.MediaPickSetting.Gallery;
        },
      ),
      Expanded(
        child: quill.QuillEditor(
          locale: const Locale('zh', 'CN'),
          controller: _contentController,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: FocusNode(),
          autoFocus: true,
          readOnly: false,
          expands: false,
          padding: EdgeInsets.zero,
          keyboardAppearance: Brightness.light,
        ),
      )
    ],
  );
}
