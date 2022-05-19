import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class BusinessCardMessageDetailsPage extends StatefulWidget {
  const BusinessCardMessageDetailsPage({Key? key}) : super(key: key);

  @override
  _BusinessCardMessageDetailsPageState createState() =>
      _BusinessCardMessageDetailsPageState();
}

class _BusinessCardMessageDetailsPageState
    extends State<BusinessCardMessageDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Message message = ModalRoute.of(context)?.settings.arguments as Message;
    BlocProvider.of<MessageBloc>(context).add(MessageRead(message));
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("详情"),
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            Contact? contact = state.contacts.firstWhereOrNull(
                (element) => element.userId == message.sendUserId);
            return contact != null
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                          color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40.0,
                              backgroundImage: contact.avatar == null
                                  ? Image.asset(
                                          'assets/icons/ic_wode_selected.png')
                                      .image
                                  : CachedNetworkImageProvider(
                                      contact.avatar.toString()),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        contact.realname,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFf68266),
                                          ),
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 12),
                                        child: Text(
                                          contact.postDictText.isEmpty
                                              ? '政协委员'
                                              : contact.postDictText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: const Color(
                                                      0xFFf68266)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('职务:'),
                                      const SizedBox(width: 6),
                                      Expanded(
                                          child:
                                              Text(contact.position ?? '')),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(children: [
                                    const Text('电话:'),
                                    const SizedBox(width: 6),
                                    Text(
                                      contact.phone.length == 11
                                          ? contact.phone.substring(0, 3) +
                                              '****' +
                                              contact.phone.substring(7)
                                          : contact.phone,
                                      style: themeData.textTheme.bodyText1
                                          ?.copyWith(
                                              color: const Color(0xFF2c7afb)),
                                    ),
                                  ]),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text('单位:'),
                                      const SizedBox(width: 6),
                                      Text(contact.company),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (contact.wxQrCode?.isNotEmpty ?? false) {
                              var response = await Dio().get(contact.wxQrCode!,
                                  options: Options(
                                      responseType: ResponseType.bytes));
                              Map result = await ImageGallerySaver.saveImage(
                                  Uint8List.fromList(response.data),
                                  quality: 80,
                                  name: contact.realname);
                              if (result.containsKey('isSuccess') &&
                                  result['isSuccess'] as bool) {
                                showToast('保存成功');
                              } else {
                                showToast('保存失败，请重试');
                              }
                            }
                          },
                          child: (contact.wxQrCode?.isEmpty ?? true)
                              ? Container()
                              : CachedNetworkImage(
                                  imageUrl: contact.wxQrCode.toString()),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '先点击“二维码”保存二维码图片，然后打开微信“扫一扫”，点击扫描图片功能呢，选择保存下来的二维码图片进行微信好友添加。',
                          style: themeData.textTheme.bodyText1
                              ?.copyWith(color: const Color(0xFFDADADA)),
                        )
                      ],
                    ),
                  )
                : Container();
          },
        ));
  }
}
