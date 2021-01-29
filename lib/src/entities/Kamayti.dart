import 'package:flutter/cupertino.dart';

import 'BaseEntity.dart';

class Kamayti extends BaseEntity {
  @override
  String id;
  @override
  dynamic createdAt;
  @override
  String createdBy;
  @override
  String createtByName;
  String description;
  int amount;
  int membersCount;
  String code;
  String type;
  String drawType;
  String status;

  Kamayti({
    @required this.description,
    @required this.amount,
    @required this.membersCount,
    @required this.code,
    @required this.type,
    @required this.drawType,
    @required this.status,
  });

  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'description': description,
      'amount': amount,
      'membersCount': membersCount,
      'code': code,
      'type': type,
      'drawType': drawType,
      'status': status,
    });

  Kamayti.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id,
        createdAt = snapshot['createdAt'],
        createdBy = snapshot['createdBy'],
        createtByName = snapshot['createtByName'],
        description = snapshot['description'],
        amount = snapshot['amount'],
        membersCount = snapshot['membersCount'],
        code = snapshot['code'],
        type = snapshot['type'],
        drawType = snapshot['drawType'],
        status = snapshot['status'];
}
