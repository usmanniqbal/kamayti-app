
import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customWidgets/DropList.dart';

class NewCommettee extends StatefulWidget {
  NewCommettee({Key key, this.maxSlide}) : super(key: key);

  final double maxSlide;

  @override
  _NewCommetteeState createState() => _NewCommetteeState();
}

class _NewCommetteeState extends State<NewCommettee> {
   TextEditingController descriptionController = new TextEditingController();
   TextEditingController noofmemberController = new TextEditingController();
   TextEditingController amountController = new TextEditingController();

  //TextFormField a = new TextFormField();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Committee',style: TextStyle(color: Colors.black,fontSize: 20),),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20,),
              _entryField('Description',descriptionController),
              SizedBox(height: 10),
              Text('Committee Type',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 10),
              DropDownList(["Select Type","Monthly","Weekly"]),
              SizedBox(height: 10),
              _entryFieldNumber('Installment Amount',amountController),
              SizedBox(height: 10),
              _entryFieldNumber('No Of Members.',noofmemberController),
              SizedBox(height: 10),
              Text('Balloting Type',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 10),
              DropDownList(["Select Type","One Time","Each Committee","Manual"]),
              SizedBox(height: 10),
              _submitButton(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  Widget _entryFieldNumber(String title,TextEditingController values ) {
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
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            width: 400.0,
            child: TextFormField(
              controller: values,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          ),
        ],
      ),
    );
  }
  Widget _entryField(String title, TextEditingController values) {
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
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            width: 400.0,
            child: TextFormField(
              controller:  values,

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
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                  maxSlide: MediaQuery.of(context).size.width * 0.835,
                )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
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
