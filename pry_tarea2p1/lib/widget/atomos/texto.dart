import 'package:flutter/material.dart';

class LabelText extends StatelessWidget{
  final String text;
  const LabelText({super.key, required this.text});
  @override
  Widget build(BuildContext context)=>Text(text, style: TextStyle(fontSize: 20));
}
