import 'package:ballotcommette_app_office/src/Enums.dart';
import 'package:ballotcommette_app_office/src/entities/Kamayti.dart';
import 'package:ballotcommette_app_office/src/entities/KamaytiMember.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';

class KamaytiService {
  static final KamaytiService _instance = KamaytiService._internal();
  KamaytiService._internal();
  factory KamaytiService() => _instance;

  final kamaytiCollection = FirebaseFirestore.instance.collection('kamayti');
  final kamaytiMemberCollection = (String id) => FirebaseFirestore.instance.collection('kamayti').doc(id).collection('members');
  final memberKamaytiCollection = FirebaseFirestore.instance.collection('member').doc(AuthService().user.uid).collection('kamaytis');
  Stream<List<Kamayti>> getMemberKamaytis() {
    return memberKamaytiCollection.snapshots().map(
          (event) => event.docs
              .map(
                (element) => Kamayti.fromMap(element.data(), element.id),
              )
              .toList(),
        );
  }

  Stream<List<KamaytiMember>> getKamaytiMembers(String kamaytiId) {
    return kamaytiMemberCollection(kamaytiId).snapshots().map(
          (event) => event.docs
              .map(
                (element) => KamaytiMember.fromMap(element.data(), element.id),
              )
              .toList(),
        );
  }

  Future<Kamayti> getKamayti(kamaytiId) async {
    final doc = await memberKamaytiCollection.doc(kamaytiId).get();
    return Kamayti.fromMap(doc.data(), doc.id);
  }

  Future create({
    @required String description,
    @required int amount,
    @required int membersCount,
    @required String type,
    @required String drawType,
  }) async {
    String code = randomAlphaNumeric(6);
    final kamayti = Kamayti(
      description: description,
      amount: amount,
      membersCount: membersCount,
      code: code,
      type: type,
      drawType: drawType,
      status: KamaytiStatus.Pending.toString(),
    );

    kamaytiCollection.add(kamayti.toJson()).then((doc) async {
      await Future.wait([
        doc.collection('members').doc(AuthService().user.uid).set(KamaytiMember(
              memberId: AuthService().user.uid,
              memberName: AuthService().user.displayName,
              photoUrl: AuthService().user.photoURL,
              isAdmin: true,
              position: 1,
            ).toJson()),
        memberKamaytiCollection.doc(doc.id).set(kamayti.toJson()),
      ]);
    });
  }

  Future<bool> join(String code) async {
    final docs = (await kamaytiCollection.where('code', isEqualTo: code).get()).docs;
    final id = docs.length > 0 ? docs.first.id : null;
    if (id == null) {
      return false;
    }
    return await Future.wait([
      kamaytiMemberCollection(id).doc(AuthService().user.uid).set(KamaytiMember(
            memberId: AuthService().user.uid,
            memberName: AuthService().user.displayName,
            photoUrl: AuthService().user.photoURL,
            isAdmin: false,
          ).toJson()),
      memberKamaytiCollection.doc(id).set(docs.first.data()),
    ]).then((value) => true);
  }

  Future<bool> ballot(String kamaytiId) {
    int counter = 1;
    return kamaytiMemberCollection(kamaytiId).get().then((value) async {
      await Future.wait(value.docs.map((doc) => kamaytiMemberCollection(kamaytiId).doc(doc.id).update({'position': counter++})));
      return true;
    });
  }
}
