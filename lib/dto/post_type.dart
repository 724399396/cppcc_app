enum PostType {
  news,
  broadcast,
  twoSessionsTopic,
  discussPoliticsFile,
  learning,
  fileAnnment,
  unknown,
}

extension TaskStatusExtension on PostType {
  String get description {
    switch (this) {
      case PostType.news:
        return '资讯';
      case PostType.broadcast:
        return '会议播报';
      case PostType.twoSessionsTopic:
        return '两会专题';
      case PostType.discussPoliticsFile:
        return '议政文件';
      case PostType.learning:
        return '委员学习';
      case PostType.fileAnnment:
        return '文件公告';
      default:
        return '未知';
    }
  }

  int get code {
    switch (this) {
      case PostType.news:
        return 1;
      case PostType.broadcast:
        return 2;
      case PostType.twoSessionsTopic:
        return 3;
      case PostType.discussPoliticsFile:
        return 4;
      case PostType.learning:
        return 5;
      case PostType.fileAnnment:
        return 6;
      default:
        return -1;
    }
  }
}

PostType convertToPostTypeFromCode(int code) {
  for (var value in PostType.values) {
    if (value.code == code) {
      return value;
    }
  }
  return PostType.unknown;
}
