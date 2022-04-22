import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendBusinessCardPage extends StatelessWidget {
  const SendBusinessCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Contact targetContact =
        ModalRoute.of(context)?.settings.arguments as Contact;
    var messageController = TextEditingController();
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("发送名片"),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    '发送名片申请',
                    style: themeData.textTheme.bodyText1
                        ?.copyWith(color: AppColors.greyTextColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                minLines: 6,
                maxLines: null,
                controller: messageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        color: AppColors.greyTextColor,
                        width: 0.0,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        color: AppColors.greyTextColor,
                        width: 0.0,
                        style: BorderStyle.solid),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8),
                  hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                  hintText: '我是...',
                ),
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 12),
              BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  return state.status == FormStatus.submissionInProgress
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 60),
                            child: Text(
                              '发送',
                              style: themeData.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (messageController.text.isEmpty) {
                              showToast('请输入申请内容');
                              return;
                            }
                            BlocProvider.of<ContactBloc>(context).add(
                              ContactSendBusinessCard(targetContact.username,
                                  messageController.text, () {
                                showToast('申请成功');
                                Navigator.pop(context);
                              }),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ));
  }
}
