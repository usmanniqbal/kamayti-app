import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double opacity;
  final double height;
  final String assetsImage;

  CustomImage({this.assetsImage, this.height, this.opacity });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            assetsImage,
            height: height,
          ),
        ),
      ),
    );
  }
}
