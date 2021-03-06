import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/dto/proposal_request.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/rich_text.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:cppcc_app/widget/quill_editor.dart';
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
            title: const Text("??????"),
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
                                  showToast('??????????????????');
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
                                    showToast('????????????');
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
                                '??????',
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
                    "??????",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  TextFormField(
                    key: const ValueKey('title'),
                    onChanged: (String? val) => title = val,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '??????????????????';
                      return null;
                    },
                    decoration: fieldDecoration.copyWith(hintText: '???????????????'),
                  ),
                  gap,
                  Text(
                    "??????",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  BlocBuilder<AppSettingBloc, AppSettingState>(
                    builder: (context, state) {
                      return DropdownButtonFormField2(
                        decoration: fieldDecoration.copyWith(hintText: '???????????????'),
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
                          if (val?.isEmpty ?? true) return '??????????????????';
                          return null;
                        },
                      );
                    },
                  ),
                  gap,
                  Text(
                    "??????",
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
                    "??????",
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
                              "?????????",
                              style: themeData.textTheme.titleMedium,
                            ),
                            dataSource: state.contacts
                                .map((e) =>
                                    {"value": e.userId, "display": e.realname})
                                .toList(),
                            textField: 'display',
                            valueField: 'value',
                            okButtonLabel: '??????',
                            cancelButtonLabel: '??????',
                            hintWidget: const Text('?????????'),
                            onSaved: (value) {
                              jointlyUsersName = (value as List<dynamic>)
                                  .map((e) => (e as String))
                                  .toList();
                            },
                          )),
                  gap,
                  Text(
                    "??????????????????",
                    style: themeData.textTheme.titleMedium,
                  ),
                  gap,
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: const Color(0xfff4f4f4))),
                    child: QuillEditor(_contentController),
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
