import 'package:flutter/material.dart';

class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Ballot Committee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.018, color: Colors.white),
          ),
          Text(
            "Version: 1.0.1\n",
            style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.white),
          )
        ],
      ),
    );
  }
}
