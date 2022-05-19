import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/dto/proposal_request.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/rich_text.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:multiselect_formfield/multiselect_formfield.dart';

class ProposalAddPage extends StatefulWidget {
  const ProposalAddPage({Key? key}) : super(key: key);

  @override
  _ProposalAddPageState createState() => _ProposalAddPageState();
}

class _ProposalAddPageState extends State<ProposalAddPage> {
  String? title;
  String? type;
  List<String>? jointlyUsersName;
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
    return BlocBuilder<ProposalBloc, ProposalState>(
      builder: (context, state) {
        var userInfo = BlocProvider.of<UserBloc>(context).state.userInfo;
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
                                String content = quillDeltaToHtml(
                                    _contentController.document.toDelta());
                                if (content.trim().isEmpty) {
                                  showToast('正文不能为空');
                                  return;
                                }
                                BlocProvider.of<ProposalBloc>(context)
                                    .add(ProposalAdd(
                                  ProposalAddRequest(
                                    content: content,
                                    title: title!,
                                    type: type!,
                                    jointlyUsers: jointlyUsersName?.join(","),
                                    workUnit: userInfo!.company,
                                    year: DateTime.now().year,
                                    authorUser: userInfo.userId,
                                  ),
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
                        items: state.dictMap['proposal_type']
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
                    "单位",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                    readOnly: true,
                    initialValue: userInfo?.company ?? '',
                    decoration: fieldDecoration,
                  ),
                  gap,
                  Text(
                    "姓名",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                    readOnly: true,
                    initialValue: userInfo?.realname ?? '',
                    decoration: fieldDecoration,
                  ),
                  gap,
                  BlocBuilder<ContactBloc, ContactState>(
                      builder: (context, state) => MultiSelectFormField(
                            autovalidate: AutovalidateMode.disabled,
                            chipBackGroundColor: AppColors.primary,
                            chipLabelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            dialogTextStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            checkBoxActiveColor: AppColors.primary,
                            checkBoxCheckColor: Colors.white,
                            dialogShapeBorder: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            title: Text(
                              "联名人",
                              style: themeData.textTheme.titleMedium,
                            ),
                            dataSource: state.contacts
                                .map((e) =>
                                    {"value": e.userId, "display": e.realname})
                                .toList(),
                            textField: 'display',
                            valueField: 'value',
                            okButtonLabel: '确认',
                            cancelButtonLabel: '取消',
                            hintWidget: const Text('请选择'),
                            onSaved: (value) {
                              jointlyUsersName = (value as List<dynamic>)
                                  .map((e) => (e as String))
                                  .toList();
                            },
                          )),
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
                    child: quillEditor(context, _contentController),
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
