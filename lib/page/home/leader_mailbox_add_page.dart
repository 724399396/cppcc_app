import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderMailboxAddPage extends StatefulWidget {
  const LeaderMailboxAddPage({Key? key}) : super(key: key);

  @override
  _LeaderMailboxAddPageState createState() => _LeaderMailboxAddPageState();
}

class _LeaderMailboxAddPageState extends State<LeaderMailboxAddPage> {
  String? type;
  String? title;
  String? content;
  String? userName;
  String? phone;
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
        return Scaffold(
          appBar: AppBar(
            title: const Text("我要写信"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (state.submitStatus ==
                          FormStatus.submissionInProgress) {
                        return;
                      }
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        BlocProvider.of<MailboxBloc>(context).add(AddMailbox(
                            type!, title!, content!, userName!, phone!, () {
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
                  ),
                ),
              ),
            ],
          ),
          body: Container(
              padding: const EdgeInsets.all(12),
              child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        gap,
                        Text("信箱类型", style: themeData.textTheme.titleMedium),
                        BlocBuilder<AppSettingBloc, AppSettingState>(
                          builder: (context, state) {
                            return DropdownButtonFormField<String>(
                              value: type,
                              isExpanded: true,
                              hint: const Text('请选择'),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff292828),
                              ),
                              items: state.dictMap['mailbox_type']
                                      ?.map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.itemValue,
                                      child: Text(value.itemText),
                                    );
                                  }).toList() ??
                                  [],
                              onChanged: (String? val) => type = val,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? val) {
                                if (val?.isEmpty ?? true) return '请选择信箱类型';
                                return null;
                              },
                              decoration: fieldDecoration,
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
                          decoration:
                              fieldDecoration.copyWith(hintText: '请输入姓名'),
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
                          decoration: fieldDecoration.copyWith(
                              hintMaxLines: 4, hintText: '请输入联系电话'),
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
                          decoration:
                              fieldDecoration.copyWith(hintText: '请输入标题'),
                        ),
                        gap,
                        Text("请输入描述", style: themeData.textTheme.titleMedium),
                        gap,
                        TextFormField(
                            minLines: 5,
                            maxLines: null,
                            key: const ValueKey('content'),
                            onChanged: (String? val) => content = val!,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? val) {
                              if (val?.isEmpty ?? true) return '描述不能为空';
                              return null;
                            },
                            decoration:
                                fieldDecoration.copyWith(hintText: '请输入描述')),
                      ],
                    ),
                  ))),
        );
      },
    );
  }
}
