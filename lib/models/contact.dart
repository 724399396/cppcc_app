import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String username;
  final String realname;
  final String postDictText;
  final String phone;
  final String company;
  final String? avatar;
  const Contact({
    required this.username,
    required this.realname,
    required this.postDictText,
    required this.phone,
    required this.company,
    required this.avatar,
  });

  Contact copyWith({
    String? username,
    String? realname,
    String? postDictText,
    String? phone,
    String? company,
    String? avatar,
  }) {
    return Contact(
      username: username ?? this.username,
      realname: realname ?? this.realname,
      postDictText: postDictText ?? this.postDictText,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  String toString() {
    return 'Contact(username: $username, realname: $realname, postDictText: $postDictText, phone: $phone, company: $company, avatar: $avatar)';
  }

  @override
  List<Object> get props {
    return [
      username,
      realname,
      postDictText,
      phone,
      company,
      avatar ?? '',
    ];
  }
}
