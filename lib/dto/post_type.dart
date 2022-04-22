enum PostType {
  news,
  learning,
  fileAnnment,
  guanduHistory,
  unknown,
}

extension TaskStatusExtension on PostType {
  String get description {
    switch (this) {
      case PostType.news:
        return '资讯';
      case PostType.fileAnnment:
        return '文件公告';
      case PostType.learning:
        return '委员学习';
      case PostType.guanduHistory:
        return '官渡文史';
      default:
        return '未知';
    }
  }

  int get code {
    switch (this) {
      case PostType.news:
        return 1;
      case PostType.fileAnnment:
        return 2;
      case PostType.learning:
        return 5;
      case PostType.guanduHistory:
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
