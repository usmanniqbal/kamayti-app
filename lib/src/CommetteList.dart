import 'dart:io';

import 'package:ballotcommette_app_office/src/NewCommette.dart';
import 'package:ballotcommette_app_office/src/entities/Kamayti.dart';
import 'package:ballotcommette_app_office/src/services/FirestoreService.dart';
import 'package:ballotcommette_app_office/src/services/KamaytiService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommetteListView extends StatelessWidget {
  CommetteListView(List<String> this._list);

  List<String> _list = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Committee List',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: _ListView(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrange,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (contexet) => NewCommettee(maxSlide: MediaQuery.of(context).size.width * 0.835)))),
    );
  }

  Widget _ListView(BuildContext context) {
    return StreamBuilder<List<Kamayti>>(
        stream: KamaytiService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data.map((Kamayti kamayti) {
              return new ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                  radius: 25.0,
                ),
                title: new Text(kamayti.description),
                subtitle: new Text("Ballot Type: $kamayti.type"),
              );
            }).toList(),
          );
        });
  }
}
