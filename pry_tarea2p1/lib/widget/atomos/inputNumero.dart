import 'package:flutter/material.dart';

class InputNumber extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  InputNumber({super.key, required this.text, required this.controller});
  @override
  Widget build(BuildContext context)=> TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: text,
    ),
  );
}