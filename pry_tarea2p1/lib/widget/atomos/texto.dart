import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const LabelText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
