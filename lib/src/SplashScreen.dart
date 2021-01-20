import 'dart:async';

import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ballotcommette_app_office/src/WelcomePage.dart';
import 'package:splashscreen/splashscreen.dart';

class KamaytiApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyKamaytiApp();
  }
}

class _MyKamaytiApp extends State<KamaytiApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new LoginPage(),
      image: new Image.asset('assets/logo.jpg'),
      photoSize: 50,
      backgroundColor: Colors.orange,
      loaderColor: Colors.black,
    );
  }
}
