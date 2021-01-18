import 'package:ballotcommette_app_office/src/Enums.dart';
import 'package:ballotcommette_app_office/src/entities/kamayti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class KamaytiService {
  static final KamaytiService _instance = KamaytiService._internal();
  KamaytiService._internal();
  factory KamaytiService() => _instance;

  final kamaytiCollection = FirebaseFirestore.instance.collection('kamayti');

  Future create({
    @required String description,
    @required int amount,
    @required int membersCount,
    @required String code,
    @required BallotType type,
  }) async {
    final kamayti = Kamayti(description: description, amount: amount, membersCount: membersCount, code: code, type: type);
    return kamaytiCollection.add(kamayti.toJson());
  }
}
