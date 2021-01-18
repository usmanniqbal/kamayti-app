import 'package:ballotcommette_app_office/src/Enums.dart';
import 'package:flutter/cupertino.dart';

import 'BaseEntity.dart';

class Kamayti extends BaseEntity {
  @override
  String id;
  @override
  dynamic createdAt;
  String description;
  int amount;
  int membersCount;
  String code;
  BallotType type;

  Kamayti({
    @required this.description,
    @required this.amount,
    @required this.membersCount,
    @required this.code,
    @required this.type,
  });

  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'description': description,
      'amount': amount,
      'membersCount': membersCount,
      'code': code,
      'type': type?.toString(),
    });

  Kamayti.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id,
        createdAt = snapshot['createdAt'],
        description = snapshot['description'],
        amount = snapshot['amount'],
        membersCount = snapshot['membersCount'],
        code = snapshot['code'],
        type = BallotType.values.firstWhere((e) => e.toString() == snapshot['type']);
}
