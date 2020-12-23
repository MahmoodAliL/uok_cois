import 'package:flutter/material.dart';

class MyAppIcon extends StatelessWidget {
  final double size;
  const MyAppIcon({
    Key key,
    this.size = 42,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/uok_cois_logo.png',
      width: size,
      height: size,
    );
  }
}
