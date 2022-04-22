import 'package:cppcc_app/bloc/guandu_historical_clue_bloc.dart';
import 'package:cppcc_app/models/guandu_historical_clue.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuanduHistoricalAddPage extends StatefulWidget {
  const GuanduHistoricalAddPage({Key? key}) : super(key: key);

  @override
  _GuanduHistoricalAddPageState createState() =>
      _GuanduHistoricalAddPageState();
}

class _GuanduHistoricalAddPageState extends State<GuanduHistoricalAddPage> {
  String? title;
  String? content;
  String? phone;
  String? provider;
  String? unit;
  bool _formChanged = false;
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
    return BlocBuilder<GuanduHistoricalClueBloc, GuanduHistoricalClueState>(
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
                            onTap: () {
                              if (state.submitStatus ==
                                  FormStatus.submissionInProgress) {
                                return;
                              }
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                BlocProvider.of<GuanduHistoricalClueBloc>(
                                        context)
                                    .add(GuanduHistoricalClueAdd(
                                  GuanduHistoricalClue(
                                      id: "",
                                      content: content!,
                                      createBy: "",
                                      createTime: "",
                                      phone: phone!,
                                      title: title!,
                                      provider: provider!,
                                      unit: unit!,
                                      read: false),
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
                    "史料主题",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                    key: const ValueKey('title'),
                    onChanged: (String? val) => title = val,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '史料主题不能为空';
                      return null;
                    },
                    decoration: fieldDecoration.copyWith(hintText: '请输入主题'),
                  ),
                  gap,
                  Text(
                    "正文（必填）",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                      minLines: 10,
                      maxLines: null,
                      key: const ValueKey('content'),
                      onChanged: (String? val) => content = val!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? val) {
                        if (val?.isEmpty ?? true) return '正文不能为空';
                        return null;
                      },
                      decoration: fieldDecoration.copyWith(
                          hintMaxLines: 4,
                          hintText:
                              '请输入有关线索：如事件发生年代、熟悉该事件的人员及联系方式、推荐撰稿人等......')),
                  gap,
                  Text(
                    "史料线索提供人",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                    key: const ValueKey('provider'),
                    onChanged: (String? val) => provider = val!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '姓名不能为空';
                      return null;
                    },
                    decoration: fieldDecoration.copyWith(hintText: '请输入姓名'),
                  ),
                  gap,
                  TextFormField(
                    key: const ValueKey('unit'),
                    onChanged: (String? val) => unit = val!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '单位名称不能为空';
                      return null;
                    },
                    decoration: fieldDecoration.copyWith(hintText: '请输入单位名称'),
                  ),
                  gap,
                  TextFormField(
                    key: const ValueKey('phone'),
                    onChanged: (String? val) => phone = val!,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '联系电话不能为空';
                      return null;
                    },
                    decoration: fieldDecoration.copyWith(hintText: '请输入联系电话'),
                  ),
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
