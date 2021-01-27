import 'package:flutter/cupertino.dart';

import 'BaseEntity.dart';

class Kamayti extends BaseEntity {
  @override
  String id;
  @override
  dynamic createdAt;
  @override
  String createdBy;
  String description;
  int amount;
  int membersCount;
  String code;
  String type;
  String drawType;

  Kamayti({@required this.description, @required this.amount, @required this.membersCount, @required this.code, @required this.type, @required this.drawType});

  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({'description': description, 'amount': amount, 'membersCount': membersCount, 'code': code, 'type': type?.toString(), 'drawType': drawType?.toString()});

  Kamayti.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id,
        createdAt = snapshot['createdAt'],
        createdBy = snapshot['createdBy'],
        description = snapshot['description'],
        amount = snapshot['amount'],
        membersCount = snapshot['membersCount'],
        code = snapshot['code'],
        type = snapshot['type'],
        drawType = snapshot['drawType'];
}
