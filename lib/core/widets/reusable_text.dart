import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  const ReusableText(
      {super.key,
      required this.text,
      this.textColor = Colors.white,
      this.fontSize = 16, this.fontWeight= FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
  }
}
