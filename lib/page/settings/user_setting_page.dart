import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var labelStyle = const TextStyle(fontSize: 18, color: Colors.black);
    var valueStyle =
        const TextStyle(fontSize: 16, color: AppColors.greyTextColor);
    return Scaffold(
      appBar: AppBar(
        title: const Text("补充资料"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: ((context, state) => Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('姓名', style: labelStyle),
                      Text(state.userInfo?.realname ?? '', style: valueStyle),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('身份证号', style: labelStyle),
                      Text(state.userInfo?.idCard ?? '', style: valueStyle),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? image =
                                        await _picker.pickImage(
                                            source: ImageSource.camera,
                                            maxWidth: 720,
                                            maxHeight: 1280);
                                    if (image != null) {
                                      showToast('图片上传中，请稍后');
                                      BlocProvider.of<UserBloc>(context).add(
                                          UserUpdateAvatarRequested(image, () {
                                        Navigator.pop(context);
                                        showToast('证件照更新成功');
                                      }));
                                    }
                                  },
                                  child: state.status ==
                                          FormStatus.submissionInProgress
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text('拍照',
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                ),
                                Container(
                                    height: 4, color: AppColors.background),
                                GestureDetector(
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? image =
                                        await _picker.pickImage(
                                            source: ImageSource.gallery,
                                            maxWidth: 720,
                                            maxHeight: 1280);
                                    if (image != null) {
                                      showToast('图片上传中，请稍后');
                                      BlocProvider.of<UserBloc>(context).add(
                                          UserUpdateAvatarRequested(image, () {
                                        Navigator.pop(context);
                                        showToast('证件照更新成功');
                                      }));
                                    }
                                  },
                                  child: state.status ==
                                          FormStatus.submissionInProgress
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text('从相册选择',
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                ),
                                Container(
                                    height: 8, color: AppColors.background),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('取消',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                                Container(
                                    height: 4, color: AppColors.background),
                              ],
                            ));
                  },
                  child: Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      children: [
                        Text('证件照', style: labelStyle),
                        Expanded(child: Container()),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          backgroundImage: state.userInfo?.avatar == null
                              ? Image.asset('assets/icons/ic_wode_selected.png')
                                  .image
                              : CachedNetworkImageProvider(
                                  state.userInfo!.avatar.toString()),
                        ),
                        const Icon(Icons.chevron_right,
                            color: AppColors.greyTextColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.updatePhonePage);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Text('手机号', style: labelStyle),
                        Expanded(child: Container()),
                        Text(state.userInfo?.phone ?? '',
                            style:
                                valueStyle.copyWith(color: Colors.grey[600])),
                        const Icon(Icons.chevron_right,
                            color: AppColors.greyTextColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? image =
                                        await _picker.pickImage(
                                            source: ImageSource.gallery,
                                            maxWidth: 720,
                                            maxHeight: 1280);
                                    if (image != null) {
                                      showToast('图片上传中，请稍后');
                                      BlocProvider.of<UserBloc>(context)
                                          .add(UserUpdateWxQrCode(image, () {
                                        Navigator.pop(context);
                                        showToast('微信二维码更新成功');
                                      }));
                                    }
                                  },
                                  child: state.status ==
                                          FormStatus.submissionInProgress
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text('从相册选择',
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                ),
                                Container(
                                    height: 8, color: AppColors.background),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('取消',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                                Container(
                                    height: 4, color: AppColors.background),
                              ],
                            ));
                  },
                  child: Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('微信二维码', style: labelStyle),
                        Expanded(child: Container()),
                        (state.userInfo?.wxQrCode?.isEmpty ?? true)
                            ? SizedBox(
                                height: 20,
                                child: Text(
                                  '上传',
                                  style:
                                      valueStyle.copyWith(color: Colors.blue),
                                ))
                            : Image(
                                height: 40,
                                image: CachedNetworkImageProvider(
                                    (state.userInfo!.wxQrCode!))),
                        const Icon(Icons.chevron_right,
                            color: AppColors.greyTextColor),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
