import 'dart:io';

import 'package:cppcc_app/repository/upload_repository.dart';
import 'package:cppcc_app/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class UploadInfo {
  final String fileName;
  final String url;

  UploadInfo(this.fileName, this.url);
}

typedef UploadCallback = void Function(List<UploadInfo> files);

class Uploader extends StatefulWidget {
  final UploadCallback callback;
  const Uploader({Key? key, required this.callback}) : super(key: key);

  @override
  State<Uploader> createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  List<UploadInfo> uploaded = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(type: FileType.media);
        if (result != null) {
          var filePath = result.files.single.path!;
          var url = await RepositoryProvider.of<UploadRepository>(context)
              .upload(File(filePath));
          setState(() {
            uploaded = uploaded + [UploadInfo(p.basename(filePath), url)];
            widget.callback(uploaded);
          });
        }
      },
      child: Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.file_upload,
                color: AppColors.greyTextColor,
                size: 24,
              ),
              Text(
                '上传附件',
                style: TextStyle(color: AppColors.greyTextColor),
              ),
            ],
          ),
          ...uploaded.map(
            (e) => GestureDetector(
              onTap: () {
                setState(() {
                  uploaded.remove(e);
                  widget.callback(uploaded);
                });
              },
              child: Row(children: [
                Expanded(
                  child: Text(
                    e.fileName,
                    style: const TextStyle(color: AppColors.greyTextColor),
                  ),
                ),
                Icon(
                  Icons.delete,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 18),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
