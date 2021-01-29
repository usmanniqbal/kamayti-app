import 'package:flutter/cupertino.dart';

import 'BaseEntity.dart';

class KamaytiMember extends BaseEntity {
  @override
  String id;
  @override
  dynamic createdAt;
  @override
  String createdBy;
  @override
  String createtByName;
  String memberId;
  String memberName;
  String photoUrl;
  int position;
  bool isAdmin;

  KamaytiMember({
    this.memberId,
    this.memberName,
    this.isAdmin,
    this.photoUrl,
    this.position,
  });

  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'memberId': memberId,
      'memberName': memberName,
      'photoUrl': photoUrl,
      'position': position,
      'isAdmin': isAdmin,
    });

  KamaytiMember.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id,
        createdAt = snapshot['createdAt'],
        createdBy = snapshot['createdBy'],
        createtByName = snapshot['createtByName'],
        memberId = snapshot['memberId'],
        memberName = snapshot['memberName'],
        photoUrl = snapshot['photoUrl'],
        position = snapshot['position'],
        isAdmin = snapshot['isAdmin'];
}
