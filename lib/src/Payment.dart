import 'package:ballotcommette_app_office/src/Enums.dart';
import 'package:ballotcommette_app_office/src/HomeScreen.dart';
import 'package:ballotcommette_app_office/src/entities/Kamayti.dart';
import 'package:ballotcommette_app_office/src/services/KamaytiService.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  Payment({this.kamaytiId});

  final String kamaytiId;
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Kamayti>(
        future: KamaytiService().getKamayti(kamaytiId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Text("Loading");
          }
          nameController.text = snapshot.data.description;
          amountController.text = snapshot.data.amount.toString();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Process Payment',
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
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          //SizedBox(height: height * .2),
                          _entryField('Kamayti Name', nameController),
                          SizedBox(height: 10),
                          _entryField('Amount', amountController),
                          _submitButton(context),
                          SizedBox(height: 20),
                        ]),
                      )),
                  //BackBtn(),
                ],
              ),
            ),
          );
        });
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
                filled: true,
              ),
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () async {
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
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.orange, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.blueGrey, Colors.blueGrey])),
        child: Text(
          'Pay',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
