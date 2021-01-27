import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/LoginPage.dart';
import 'package:ballotcommette_app_office/src/SplashPage.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Text("Something went wronge");
            } // Once complete, show your application
            else if (snapshot.connectionState == ConnectionState.done) {
              return ChangeNotifierProvider(
                create: (_) => AuthService.instance(),
                child: Consumer(
                  builder: (context, AuthService service, _) {
                    switch (service.appState) {
                      case AppState.initial:
                        return SplashPage();
                      case AppState.unauthenticated:
                      case AppState.authenticating:
                        return LoginPage();
                      case AppState.authenticated:
                        return HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835);
                      default:
                        return Container();
                    }
                  },
                ),
              );
            } else {
              return Text("Loading");
            }
          },
        ));
  }
}
