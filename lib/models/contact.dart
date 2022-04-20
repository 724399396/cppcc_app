import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String username;
  final String realname;
  final String postDictText;
  final String phone;
  final String idCard;
  final String company;
  final String? avatar;
  final String? wxQrCode;
  final String? position;
  const Contact({
    required this.username,
    required this.realname,
    required this.postDictText,
    required this.phone,
    required this.idCard,
    required this.company,
    required this.avatar,
    required this.wxQrCode,
    required this.position,
  });

  Contact copyWith({
    String? username,
    String? realname,
    String? postDictText,
    String? phone,
    String? idCard,
    String? company,
    String? avatar,
    String? wxQrCode,
    String? position,
  }) {
    return Contact(
      username: username ?? this.username,
      realname: realname ?? this.realname,
      postDictText: postDictText ?? this.postDictText,
      phone: phone ?? this.phone,
      idCard: idCard ?? this.idCard,
      company: company ?? this.company,
      avatar: avatar ?? this.avatar,
      wxQrCode: wxQrCode ?? this.wxQrCode,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'Contact(username: $username, realname: $realname, postDictText: $postDictText, phone: $phone, idCard: $idCard, company: $company, avatar: $avatar, wxQrCode: $wxQrCode, position: $position)';
  }

  @override
  List<Object> get props {
    return [
      username,
      realname,
      postDictText,
      phone,
      idCard,
      company,
      avatar ?? '',
      wxQrCode ?? '',
      position ?? '',
    ];
  }
}
