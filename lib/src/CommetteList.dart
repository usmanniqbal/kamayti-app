import 'dart:io';

import 'package:ballotcommette_app_office/src/NewCommette.dart';
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
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (contexet) =>
                  NewCommettee(
                      maxSlide: MediaQuery
                          .of(context)
                          .size
                          .width * 0.835)))
      ),

    );
  }

  Widget _ListView(BuildContext context) {
    return ListView.separated(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return Card(
          shadowColor: Colors.grey,
            child: ListTile(
              onTap: () {},
              title: Text(_list[index]),
              subtitle: Text("Month : January \n Amount : 10,000.00"),
            ),
          );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
