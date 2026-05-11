import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    
    if (text.isEmpty) {
      return newValue;
    }

    
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return oldValue;
    }

    
    if (text.split('.').length > 2) {
      return oldValue;
    }

    
    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts[1].length > 2) {
        return oldValue;
      }
    }

    return newValue;
  }
}

class InputDecimal extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const InputDecimal({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        DecimalFormatter(),
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: text,
      ),
    );
  }
}