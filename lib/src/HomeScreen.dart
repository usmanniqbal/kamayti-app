import 'dart:io';
import 'dart:math' as math;

import 'package:ballotcommette_app_office/src/CommetteList.dart';
import 'package:ballotcommette_app_office/src/MemberRegistration.dart';
import 'package:ballotcommette_app_office/src/NewCommette.dart';
import 'package:ballotcommette_app_office/src/WelcomePage.dart';
import 'package:ballotcommette_app_office/src/views/daystart.dart';
import 'package:flutter/material.dart';

import 'Widget/Drawer.dart';
import 'animations/bottomAnimation.dart';

class HomeScreen extends StatefulWidget {
  final double maxSlide;

  HomeScreen({@required this.maxSlide});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  //final double maxSlide = 300.0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  bool _canBeDragged;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / widget.maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: new Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text("Are You Sure?"),
            actions: <Widget>[
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  "No",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Material(
                color: Colors.orange,
                child: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(
                            widget.maxSlide * (animationController.value - 1),
                            0),
                        child: Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(math.pi /
                                  2 *
                                  (1 - animationController.value)),
                            alignment: Alignment.centerRight,
                            child: MyDrawer()),
                      ),
                      Transform.translate(
                        offset: Offset(
                            widget.maxSlide * animationController.value, 0),
                        child: Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(
                                  -math.pi / 2 * animationController.value),
                            alignment: Alignment.centerLeft,
                            child: MainScreen(context)), //Main Screen Widget
                      ),
                      Positioned(
                        top: 4.0 + MediaQuery.of(context).padding.top,
                        left: width * 0.01 +
                            animationController.value * widget.maxSlide,
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: toggle,
                          color: Colors.white,
                        ),
                      ),
//                  Positioned(
//                      top: height * 0.13,
//                      left: width * 0.04 +
//                          animationController.value *
//                              MediaQuery.of(context).size.width,
//                      width: MediaQuery.of(context).size.width,
//                      child: AppName(context)),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget AppName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("Ballot", style: Theme.of(context).textTheme.headline2),
        Text(
          "Commette",
          style: Theme.of(context).textTheme.headline2,
        )
      ],
    );
  }

  Widget MainScreen(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xffdf8e33).withAlpha(100),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AppName(context),
            Calligraphy(context),
            //CommetteLogo(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  MemberRegistartion(),
                  NewCommettee(),
                  CommetteList(),
                  PaymentGateWay(),
                  CommetteHistoy()
                ],
              ),
            ),
            CompanyDetail(),
          ],
        ));
  }

  Widget Calligraphy(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
        right: width * 0.01,
        top: height * 0.045,
        child: Image.asset(
          "assets/logo.jpg",
          height: height * 0.20,
        ));
  }
}

class CommetteLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
        left: width * 0,
        bottom: height * 0.0,
        child: Opacity(
          opacity: 0.2,
          child: Image.asset("assets/logo.jpg", height: height * 0.43),
        ));
  }
}

class CompanyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text("\"Reaching Out Enriching Lives\"\n",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Text("Mcs Team From MAJU\n",
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}

class MemberRegistartion extends StatelessWidget {
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
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(

                builder: (context) => MemberRegistration(
                  maxSlide: MediaQuery.of(context).size.width * 0.835,

                  // builder: (context) => StartDay(
                  //   maxSlide: MediaQuery.of(context).size.width * 0.835,
                  ))),
          child: WidgetAnimator(Text("Become a Member",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
class CommetteList extends StatelessWidget {
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
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommetteListView([
                    "Running Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee",
                    "2nd Last Committee"
                  ]))),
          child: WidgetAnimator(Text("Committee List",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
class PaymentGateWay extends StatelessWidget {
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
          child: WidgetAnimator(Text("Payment Gateway",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
class CommetteHistoy extends StatelessWidget {
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
            Navigator.pushNamed(context, '/ManzilIndex');
          },
          child: WidgetAnimator(Text("Commette History",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontWeight: FontWeight.w600))),
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
