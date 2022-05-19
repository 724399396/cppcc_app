import 'dart:io';

import 'package:cppcc_app/repository/upload_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class UrlFileOpener extends StatelessWidget {
  final String url;
  const UrlFileOpener(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fileName = url;
    int urlLastSplit = url.lastIndexOf("/");
    if (urlLastSplit > 0) {
      fileName = url.substring(urlLastSplit + 1);
    }
    return GestureDetector(
      onTap: () async {
        var tempDir = await getTemporaryDirectory();
        String fullPath = tempDir.path + "/" + fileName;
        File file = File(fullPath);
        bool exists = await file.exists();
        DateTime? lastModified = exists ? await file.lastModified() : null;
        DateTime oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
        if (!exists || (lastModified?.isBefore(oneDayAgo) ?? true)) {
          var bytes = await RepositoryProvider.of<FileRepository>(context)
              .download(url);
          await file.writeAsBytes(bytes);
        }
        OpenFile.open(fullPath);
      },
      child: Text(fileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.blueAccent)),
    );
  }
}
