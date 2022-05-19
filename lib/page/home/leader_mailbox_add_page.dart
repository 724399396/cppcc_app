import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/dto/mailbox_request.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/rich_text.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:cppcc_app/widget/quill_editor.dart';
import 'package:cppcc_app/widget/uploader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class LeaderMailboxAddPage extends StatefulWidget {
  const LeaderMailboxAddPage({Key? key}) : super(key: key);

  @override
  _LeaderMailboxAddPageState createState() => _LeaderMailboxAddPageState();
}

class _LeaderMailboxAddPageState extends State<LeaderMailboxAddPage> {
  String? type;
  String? open = '2';
  String? title;
  String? userName;
  String? phone;
  List<UploadInfo>? files;
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
    return BlocBuilder<MailboxBloc, MailboxState>(
      builder: (context, state) {
        var userInfo = BlocProvider.of<UserBloc>(context).state.userInfo;
        userName = userInfo?.realname;
        phone = userInfo?.phone;
        return Scaffold(
          appBar: AppBar(
            title: const Text("我要写信"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Center(
                      child: state.submitStatus ==
                              FormStatus.submissionInProgress
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
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  String content = quillDeltaToHtml(
                                      _contentController.document.toDelta());
                                  if (content.trim().isEmpty) {
                                    showToast('正文不能为空');
                                    return;
                                  }
                                  BlocProvider.of<MailboxBloc>(context).add(
                                      AddMailbox(
                                          AddMailRequest(
                                              content: content,
                                              isOpen: open!,
                                              phone: phone!,
                                              title: title!,
                                              type: type!,
                                              userId: userInfo!.userId,
                                              appendix: files
                                                  ?.map((e) => e.url)
                                                  .join(',')), () {
                                    showToast('添加成功');
                                    Navigator.of(context).pop();
                                  }));
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
              ),
            ],
          ),
          body: Container(
              padding: const EdgeInsets.all(12),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      gap,
                      Text("信箱类型", style: themeData.textTheme.titleMedium),
                      BlocBuilder<AppSettingBloc, AppSettingState>(
                        builder: (context, state) {
                          return DropdownButtonFormField2<String>(
                            decoration:
                                fieldDecoration.copyWith(hintText: '请选择类型'),
                            items: state.dictMap['mailbox_type']
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
                            onChanged: (String? val) => type = val,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? val) {
                              if (val?.isEmpty ?? true) return '请选择信箱类型';
                              return null;
                            },
                          );
                        },
                      ),
                      Text("信件公开", style: themeData.textTheme.titleMedium),
                      BlocBuilder<AppSettingBloc, AppSettingState>(
                        builder: (context, state) {
                          return DropdownButtonFormField2<String>(
                            decoration:
                                fieldDecoration.copyWith(hintText: '请选择是否公开'),
                            items: state.dictMap['mail_is_open']
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
                            value: open,
                            onChanged: (String? val) => open = val,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? val) {
                              if (val?.isEmpty ?? true) return '请选择是否公开';
                              return null;
                            },
                          );
                        },
                      ),
                      gap,
                      Text("姓名", style: themeData.textTheme.titleMedium),
                      gap,
                      TextFormField(
                        key: const ValueKey('userId'),
                        onChanged: (String? val) => userName = val!,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? val) {
                          if (val?.isEmpty ?? true) return '姓名不能为空';
                          return null;
                        },
                        decoration: fieldDecoration.copyWith(hintText: '请输入姓名'),
                        initialValue: userName,
                      ),
                      gap,
                      Text("联系电话", style: themeData.textTheme.titleMedium),
                      gap,
                      TextFormField(
                        key: const ValueKey('phone'),
                        onChanged: (String? val) => phone = val!,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? val) {
                          if (val?.isEmpty ?? true) return '电话不能为空';
                          return null;
                        },
                        initialValue: phone,
                        decoration:
                            fieldDecoration.copyWith(hintText: '请输入联系电话'),
                      ),
                      gap,
                      Text("标题(必填)", style: themeData.textTheme.titleMedium),
                      gap,
                      TextFormField(
                        key: const ValueKey('title'),
                        onChanged: (String? val) => title = val!,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? val) {
                          if (val?.isEmpty ?? true) return '标题不能为空';
                          return null;
                        },
                        decoration: fieldDecoration.copyWith(hintText: '请输入标题'),
                      ),
                      gap,
                      Text(
                        "正文（必填）",
                        style: themeData.textTheme.titleMedium,
                      ),
                      gap,
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xfff4f4f4))),
                        child: QuillEditor(_contentController),
                      ),
                      gap,
                      Uploader(callback: (List<UploadInfo> uploadedFiles) {
                        files = uploadedFiles;
                      }),
                    ],
                  ))),
        );
      },
    );
  }
}
