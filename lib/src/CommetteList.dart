import 'dart:io';

import 'package:ballotcommette_app_office/src/Enums.dart';
import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/MemberList.dart';
import 'package:ballotcommette_app_office/src/NewCommette.dart';
import 'package:ballotcommette_app_office/src/Payment.dart';
import 'package:ballotcommette_app_office/src/Widget/floatingactionbutton.dart';
import 'package:ballotcommette_app_office/src/entities/Kamayti.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:ballotcommette_app_office/src/services/FirestoreService.dart';
import 'package:ballotcommette_app_office/src/services/KamaytiService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommetteListView extends StatelessWidget {
  final String title;
  CommetteListView(this.title);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // AuthService().user.displayName,
          title,
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
      floatingActionButton: title == "Committee List" ? FancyFab() : SizedBox(),
    );
  }

  Widget _listView(BuildContext context) {
    return StreamBuilder<List<Kamayti>>(
        stream: KamaytiService().getMemberKamaytis(),
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
                .map((Kamayti kamayti) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(title == "Committee List" ? 'assets/logo.jpg' : 'assets/cash.png'),
                        radius: 25.0,
                        backgroundColor: Colors.orange[200],
                      ),
                      title: Text(kamayti.description),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Code: ${kamayti.code}"),
                          Text("Admin: ${kamayti.createtByName}"),
                        ],
                      ),
                      onTap: () {
                        if (title != "Committee List") {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(kamaytiId: kamayti.id)));
                        }
                      },
                      isThreeLine: true,
                      trailing: title != "Committee List"
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(0),
                              child: SizedBox(
                                  width: 50,
                                  child: PopupMenuButton(
                                    itemBuilder: (context) {
                                      final result = <PopupMenuEntry<String>>[];

                                      result.add(PopupMenuItem(
                                        value: "members",
                                        child: Text("Members"),
                                      ));
                                      if (kamayti.createdBy == AuthService().user.uid && (kamayti.status == null || kamayti.status == KamaytiStatus.Pending.toString())) {
                                        result.add(PopupMenuItem(
                                          value: "ballot",
                                          child: Text("Start Balloting"),
                                        ));
                                      }
                                      return result;
                                    },
                                    onSelected: (String value) {
                                      switch (value) {
                                        case "members":
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => MemberList(kamaytiId: kamayti.id)));
                                          break;
                                        case "ballot":
                                          KamaytiService().ballot(kamayti.id).then((value) {
                                            if (value) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MemberList(kamaytiId: kamayti.id)));
                                            }
                                          });
                                          break;
                                        default:
                                      }
                                    },
                                  )),
                            ),
                    ))
                .toList(),
          );
        });
  }
}
