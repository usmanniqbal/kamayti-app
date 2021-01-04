import 'package:flutter/material.dart';

class ClipPainter extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);

    //[Top Left corner]
    var secondControlPoint = Offset(0,0);
    var secondEndPoint = Offset(width * .2,height *.3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    //[Left Middle]
    var fifthControlPoint = Offset(width*.3,height*.5);
    var fifthEndPoint = Offset(width*.23,height*.6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy, fifthEndPoint.dx, fifthEndPoint.dy);

    path.lineTo(0, height);
    path.close();
    throw Path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }

}