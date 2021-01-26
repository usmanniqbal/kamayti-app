import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/customWidgets/appVersion.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  myListTile(BuildContext context, double height, IconData tileIcon, String title, {Widget widget, GestureTapCallback onTap}) {
    return Card(
        color: Color(0xffdf8e33),
        child: ListTile(
            leading: Icon(tileIcon, size: height * 0.035),
            title: Text(title),
            onTap: onTap ??
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget,
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.835,
      height: height,
      child: Material(
        color: Color(0xffdf8e33),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerAppName(context),
              Column(
                children: <Widget>[
                  myListTile(context, height, Icons.format_list_bulleted, "List", onTap: () {}),
                  //myListTile(context, height, Icons.location_on, "Location", onTap: (){}),
                  myListTile(context, height, Icons.payments_sharp, "Paymet Gateway", onTap: () {}),
                  myListTile(context, height, Icons.format_list_numbered, "Commette History", onTap: () {}),
                  myListTile(context, height, Icons.help, "Help Guide", onTap: () {}),
                  myListTile(context, height, Icons.share, "Share App", onTap: () {}),
                  myListTile(context, height, Icons.logout, "Logout", onTap: () => AuthService.instance().signOut()),
                ],
              ),
              AppVersion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DrawerInfo(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(0, height * 0.22, 0, height * 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MetaData(context),
          //MetaDataInfo(),
        ],
      ),
    );
  }

  Widget MetaData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Surahs: "),
        Text("Ayahs: "),
        Text("Rukus: "),
        Text("Sajood: "),
        Text("Meccan Ch: "),
        Text("Mednian Ch: "),
      ],
    );
  }

  Widget MetaDataInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text("114"),
        Text("6,666"),
        Text("558"),
        Text("15"),
        Text("86"),
        Text("28"),
      ],
    );
  }

  Widget DrawerAppName(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "\nBallot",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: height * 0.025, color: Colors.white),
            ),
            Text(
              "Committee",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: height * 0.035),
            )
          ],
        ),
        Image.asset('assets/logo.jpg', height: 100, width: 100)
      ],
    );
  }

  Widget AppName(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.12,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text("The", style: Theme.of(context).textTheme.headline2),
          Text(
            "\nBallot",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
          ),
          Text(
            "\n Committee",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          )
        ],
      ),
    );
  }
}
