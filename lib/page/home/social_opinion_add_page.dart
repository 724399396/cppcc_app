import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/dto/opinion_request.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class SocialOpinionAddPage extends StatefulWidget {
  const SocialOpinionAddPage({Key? key}) : super(key: key);

  @override
  _SocialOpinionAddPageState createState() => _SocialOpinionAddPageState();
}

class _SocialOpinionAddPageState extends State<SocialOpinionAddPage> {
  String? title;
  String? type;
  bool _formChanged = false;
  final quill.QuillController _contentController =
      quill.QuillController.basic();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var gap = const SizedBox(height: 6);
    var fieldDecoration = InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(
            color: Color(0xfff4f4f4), width: 1, style: BorderStyle.solid),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(
            color: Color(0xfff4f4f4), width: 1.8, style: BorderStyle.solid),
      ),
      isDense: true,
      contentPadding: const EdgeInsets.all(8),
      hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: AppColors.greyTextColor,
          ),
    );
    return BlocBuilder<OpinionBloc, OpinionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("新增"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Center(
                    child: state.submitStatus == FormStatus.submissionInProgress
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (state.submitStatus ==
                                  FormStatus.submissionInProgress) {
                                return;
                              }
                              if (_formKey.currentState?.validate() ?? false) {
                                String content =
                                    _contentController.document.toPlainText();
                                if (content.trim().isEmpty) {
                                  showToast('正文不能为空');
                                  return;
                                }
                                BlocProvider.of<OpinionBloc>(context)
                                    .add(OpinionAdd(
                                  OpinionAddRequest(
                                      content: content,
                                      title: title!,
                                      type: type!,
                                      authorUser:
                                          BlocProvider.of<UserBloc>(context)
                                              .state
                                              .userInfo!
                                              .userId!),
                                  () {
                                    showToast('添加成功');
                                    Navigator.of(context).pop();
                                  },
                                ));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: const Text(
                                '提交',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              onChanged: _onFormChange,
              child: ListView(
                children: [
                  Text(
                    "标题",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                    key: const ValueKey('title'),
                    onChanged: (String? val) => title = val,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '标题不能为空';
                      return null;
                    },
                    decoration: fieldDecoration.copyWith(hintText: '请输入标题'),
                  ),
                  gap,
                  Text(
                    "类别",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  BlocBuilder<AppSettingBloc, AppSettingState>(
                    builder: (context, state) {
                      return DropdownButtonFormField2(
                        decoration: fieldDecoration.copyWith(hintText: '请选择类别'),
                        items: state.dictMap['opinion_type']
                            ?.map((item) => DropdownMenuItem<String>(
                                  value: item.itemValue,
                                  child: Text(
                                    item.itemText,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: type,
                        onChanged: (value) {
                          setState(() {
                            type = value as String;
                          });
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? val) {
                          if (val?.isEmpty ?? true) return '类型不能为空';
                          return null;
                        },
                      );
                    },
                  ),
                  gap,
                  Text(
                    "正文（必填）",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: const Color(0xfff4f4f4))),
                    child: Column(
                      children: [
                        quill.QuillToolbar.basic(
                          controller: _contentController,
                          locale: const Locale('zh', 'CN'),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }
}
