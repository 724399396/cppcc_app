import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrBusinessCardPage extends StatelessWidget {
  const QrBusinessCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("二维码名片"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            var userInfo = state.userInfo;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40.0,
                          backgroundImage: (userInfo?.avatar?.isEmpty ?? true)
                              ? Image.asset('assets/icons/ic_wode_selected.png')
                                  .image
                              : CachedNetworkImageProvider(userInfo!.avatar!),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    userInfo?.realname ?? '',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFf68266),
                                      ),
                                      borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 12),
                                    child: Text(
                                      (userInfo?.postDictText.isEmpty ?? true)
                                          ? '政协委员'
                                          : userInfo!.postDictText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: const Color(0xFFf68266)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('职务:'),
                                  const SizedBox(width: 6),
                                  Expanded(child: Text(userInfo?.position ?? '')),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(children: [
                                const Text('电话:'),
                                const SizedBox(width: 6),
                                Text(
                                  userInfo?.phone.length == 11
                                      ? (userInfo?.phone.substring(0, 3) ?? '') +
                                          '****' +
                                          (userInfo?.phone.substring(7) ?? '')
                                      : userInfo!.phone,
                                ),
                              ]),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text('单位:'),
                                  const SizedBox(width: 6),
                                  Text(userInfo?.company ?? ''),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      (userInfo?.wxQrCode?.isEmpty ?? true)
                          ? Container()
                          : CachedNetworkImage(
                              width: 300, imageUrl: userInfo!.wxQrCode!)
                    ],
                  )),
                ],
              ),
            );
          },
        ));
  }
}
