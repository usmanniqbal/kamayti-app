import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/Widget/customRaisebutton.dart';
import 'package:ballotcommette_app_office/src/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(top: -height * .15, right: -MediaQuery.of(context).size.width * .4, child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(context),
                  SizedBox(height: 60),
                  //_emailPasswordWidget(),
                  SizedBox(height: 70),
                  CustomRaiseButton(
                    color: Colors.white,
                    borderRadius: 4.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/google.jpg',
                          height: 30.0,
                        ),
                        Text('Google Sign In'),
                        Opacity(
                          opacity: 0.0,
                          child: Image.asset('assets/google.jpg'),
                        )
                      ],
                    ),
                    onpress: () => _signinGoogle(context),
                  ), //_submitButton(context),
                  SizedBox(height: height * .055),
                ],
              ),
            ),
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(obscureText: isPassword, decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true))
        ],
      ),
    );
  }

  Future<void> _signinGoogle(BuildContext context) async {
    try {
      await AuthService.instance().signInWithGoogle();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Fail!"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Ballot',
          style: GoogleFonts.portLligatSans(textStyle: Theme.of(context).textTheme.display1, fontSize: 30, fontWeight: FontWeight.w700, color: Colors.amber),
          children: [TextSpan(text: ' Committee', style: TextStyle(color: Colors.black, fontSize: 30))]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }
}
