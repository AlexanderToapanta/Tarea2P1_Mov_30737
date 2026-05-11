import 'package:flutter/material.dart';

class ResultText extends StatelessWidget{
  final String text;
  const ResultText({super.key, required this.text});

  @override
  Widget build(BuildContext context)=>Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
}
