import 'package:ballotcommette_app_office/src/Enums.dart';
import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/services/KamaytiService.dart';
import 'package:flutter/material.dart';

class MemberRegistration extends StatefulWidget {
  MemberRegistration({Key key, this.maxSlide}) : super(key: key);

  final double maxSlide;

  @override
  _MemberRegistrationState createState() => _MemberRegistrationState();
}

class _MemberRegistrationState extends State<MemberRegistration> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final membersCountController = TextEditingController();
  final codeController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Member Registration',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: height * .2),
                        _entryField('Description', nameController),
                        SizedBox(height: 10),
                        _entryField('Amount', amountController),
                        SizedBox(height: 10),
                        _entryField('Members Count', membersCountController),
                        SizedBox(height: 10),
                        _entryField('Code', codeController),
                        SizedBox(height: 10),
                        _entryField('Balloting Type', typeController),
                        SizedBox(height: 10),
                        // _entryField('Reference'),
                        // SizedBox(height: 10),
                        _submitButton(),
                        SizedBox(height: 20),
                      ]),
                )),
            //BackBtn(),
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller) {
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
          Container(
            width: 350.0,
            child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        await KamaytiService().create(
          description: 'nameController.text',
          amount: 0,
          //int.parse(amountController.text),
          membersCount: 0,
          //int.parse(membersCountController.text),
          code: 'codeController.text',
          type: BallotType.Once,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      maxSlide: MediaQuery.of(context).size.width * 0.835,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.orange,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blueGrey, Colors.blueGrey])),
        child: Text(
          'Registered',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
