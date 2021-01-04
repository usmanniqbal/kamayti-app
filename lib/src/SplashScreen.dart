import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamayti_app_office/src/WelcomePage.dart';
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
      seconds: 5,
      navigateAfterSeconds: new WelcomePage(),
      title: new Text(
        'Kamayti Application',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
      ),
      image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.orange,
      loaderColor: Colors.black,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome In Kamayti Applicaton'),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          'Succeeded!',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
