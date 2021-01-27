import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  List<String> list = [];
  TextEditingController controller;
  @override
  _DropDownListState createState() => _DropDownListState();

  DropDownList({
    @required this.list,
    @required this.controller,
  });
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return _hintDown();
  }

  String dropdownValue = 'Select Type';
  Widget _hintDown() => Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8.0), color: Colors.white),
      child: Padding(
          padding: EdgeInsets.all(5.0),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 30, //this inicrease the size
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(),
            onChanged: (String newValue) {
              setState(() {
                widget.controller.text = dropdownValue = newValue;
              });
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )));
}
