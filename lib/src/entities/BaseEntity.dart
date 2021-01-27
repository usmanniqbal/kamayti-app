import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseEntity {
  String id;
  dynamic createdAt;
  String createdBy;

  Map<String, dynamic> toJson() => {
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': AuthService.user.uid,
      };
}
