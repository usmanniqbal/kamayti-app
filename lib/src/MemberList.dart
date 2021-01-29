import 'dart:io';

import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/NewCommette.dart';
import 'package:ballotcommette_app_office/src/Widget/floatingactionbutton.dart';
import 'package:ballotcommette_app_office/src/entities/Kamayti.dart';
import 'package:ballotcommette_app_office/src/entities/KamaytiMember.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:ballotcommette_app_office/src/services/FirestoreService.dart';
import 'package:ballotcommette_app_office/src/services/KamaytiService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemberList extends StatelessWidget {
  final String kamaytiId;
  MemberList({@required this.kamaytiId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // "AuthService().user.displayName",
          "Members",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: Container(
        child: Column(
          children: [
            _listView(context),
          ],
        ),
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return StreamBuilder<List<KamaytiMember>>(
        stream: KamaytiService().getKamaytiMembers(this.kamaytiId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data
                .map((KamaytiMember member) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: member.photoUrl != null ? NetworkImage(member.photoUrl) : AssetImage('assets/logo_.jpg'),
                        radius: 25.0,
                      ),
                      title: Text(member.memberName),
                    ))
                .toList(),
          );
        });
  }
}
