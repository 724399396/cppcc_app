import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContacts extends StatefulWidget {
  const HomeContacts({Key? key}) : super(key: key);

  @override
  _HomeContactsState createState() => _HomeContactsState();
}

class _HomeContactsState extends State<HomeContacts> {
  String _keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "通讯录",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: GeneralSearch(
              AppColors.greyTextColor,
              ((context, keyword) {
                setState(() {
                  _keyword = keyword;
                });
              }),
              initValue: _keyword,
              hint: '请输入查找姓名',
              fillColor: Colors.white,
            ),
          ),
          Expanded(child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  var data = state.contacts
                      .where((element) =>
                          element.username != userState.userInfo?.username &&
                          (_keyword.isEmpty ||
                              element.realname.contains(_keyword)))
                      .toList();
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ContactItem(data[index]);
                    },
                    itemCount: data.length,
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  const ContactItem(this.contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.contactDetailPage,
          arguments: contact,
        );
      },
      child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CircleAvatar(
                  backgroundColor: AppColors.background,
                  radius: 28.0,
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundImage: contact.avatar == null
                        ? Image.asset('assets/icons/ic_wode_selected.png').image
                        : CachedNetworkImageProvider(contact.avatar.toString()),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      contact.realname,
                      style: themeData.textTheme.titleMedium,
                    ),
                  )),
                  Container(
                    height: 0.4,
                    color: AppColors.greyTextColor,
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
