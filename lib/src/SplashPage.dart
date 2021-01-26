import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/LoginPage.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
      seconds: 3,
      // navigateAfterSeconds: _showScreen(context),
      image: new Image.asset('assets/logo.jpg'),
      photoSize: 50,
      backgroundColor: Colors.orange,
      loaderColor: Colors.black,
    );
  }
}
