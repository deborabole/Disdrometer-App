import 'package:flutter/material.dart';

class SheetHeader extends StatelessWidget {
  final double fontSize, topMargin;

  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text('Rainfall Info',
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.teal[700],
              fontWeight: FontWeight.bold)),
    );
  }
}
