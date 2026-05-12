import 'package:flutter/material.dart';

class InputTexto extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const InputTexto({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: text,
    ),
  );
}
