import 'package:ballotcommette_app_office/src/animations/bottomAnimation.dart';
import 'package:ballotcommette_app_office/src/customWidgets/backBtn.dart';
import 'package:ballotcommette_app_office/src/customWidgets/customImagePos.dart';
import 'package:ballotcommette_app_office/src/customWidgets/flare.dart';
import 'package:ballotcommette_app_office/src/customWidgets/title.dart';
import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:flutter/material.dart';

class StartDay extends StatelessWidget {
  final double maxSlide;

  const StartDay({Key key, this.maxSlide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blueGrey[700],
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CommetteLogo(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ScanOrder(),
                        LiveLocation(),
                        LiveDateTime()
                      ],
                    ),
                  ),
                  CompanyDetail(),
                ],
              )),
          BackBtn(),
          CustomImage(
            opacity: 0.4,
            height: height * 0.1,
            assetsImage: "assets/premier.png",
          ),
          CustomTitle(
            title: "Day Start",
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 17),
            left: 100,
            height: 60,
            width: 60,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 12),
            left: 10,
            height: 25,
            width: 25,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -40,
            left: -100,
            flareDuration: Duration(seconds: 18),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            left: -80,
            flareDuration: Duration(seconds: 15),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -20,
            left: -120,
            flareDuration: Duration(seconds: 12),
            height: 40,
            width: 40,
          ),
        ],
      )),
    );
  }
}

class ScanOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.06,
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/juzzIndex');
          },
          child: WidgetAnimator(Text("Scan Order",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.lightGreenAccent[700],
        ),
      ),
    );
  }
}

class LiveLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.06,
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/juzzIndex');
          },
          child: WidgetAnimator(Text("Location",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.lightGreenAccent[700],
        ),
      ),
    );
  }
}

class LiveDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.06,
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/juzzIndex');
          },
          child: WidgetAnimator(Text("Date Time",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.lightGreenAccent[700],
        ),
      ),
    );
  }
}
