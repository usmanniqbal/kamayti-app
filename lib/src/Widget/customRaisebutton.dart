import 'package:flutter/material.dart';

class CustomRaiseButton extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final VoidCallback onpress;
  final Widget child;

  CustomRaiseButton({@required this.color,this.borderRadius,this.child,this.onpress}):assert(color!=null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: RaisedButton(
        color: color,
        child: child,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
        ),
        onPressed: onpress,
      ),
    );
  }
}
