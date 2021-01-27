import 'package:ballotcommette_app_office/src/entities/Kamayti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';

class KamaytiService {
  static final KamaytiService _instance = KamaytiService._internal();
  KamaytiService._internal();
  factory KamaytiService() => _instance;

  final kamaytiCollection = FirebaseFirestore.instance.collection('kamayti');

  Future create({
    @required String description,
    @required int amount,
    @required int membersCount,
    @required String type,
    @required String drawType,
  }) async {
    String code = randomAlphaNumeric(6);
    final kamayti = Kamayti(description: description, amount: amount, membersCount: membersCount, code: code, type: type, drawType: drawType);
    return kamaytiCollection.add(kamayti.toJson());
  }

  Stream<List<Kamayti>> getAll() => kamaytiCollection.snapshots().map((event) => event.docs.map((element) => Kamayti.fromMap(element.data(), element.id)).toList());
}
