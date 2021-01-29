import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AppState { initial, authenticated, authenticating, unauthenticated }

class AuthService with ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  AuthService._internal();
  factory AuthService() => _instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static AppState _appState = AppState.initial;
  AppState get appState => _appState;
  User get user => FirebaseAuth.instance.currentUser;

  AuthService.instance() {
    _auth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;
      } else {
        _appState = AppState.authenticated;
      }

      notifyListeners();
    });
  }

  Future<bool> signInWithGoogle() async {
    try {
      _appState = AppState.authenticating; //set current state to loading state.
      notifyListeners();

      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      if (googleUser == null) {
        return throw new Exception("Please sign in from valid google id.");
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      _appState = AppState.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    return Future.delayed(Duration.zero);
  }
}
