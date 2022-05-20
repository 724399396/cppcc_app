import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String? content;
  String? type;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("建议反馈"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Center(
                    child: state.status == FormStatus.submissionInProgress
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
                              if (state.status ==
                                  FormStatus.submissionInProgress) {
                                return;
                              }
                              if (_formKey.currentState?.validate() ?? false) {
                                BlocProvider.of<UserBloc>(context)
                                    .add(UserFeedback(
                                  content!,
                                  () {
                                    showToast('反馈成功');
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
              )
            ],
          ),
          body: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("您的建议与反馈",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff292828),
                          )),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextFormField(
                          key: const ValueKey('keyword'),
                          maxLines: 15,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                  color: Color(0xfff4f4f4),
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                  color: Color(0xfff4f4f4),
                                  width: 1.2,
                                  style: BorderStyle.solid),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(8),
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: const Color(0xffaaaaaa),
                                    ),
                            hintText: '请输入反馈内容',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? val) {
                            if (val?.isEmpty ?? true) return '反馈内容不能为空';
                            return null;
                          },
                          onChanged: (String? val) => content = val,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
