import 'package:flutter/material.dart';
import '../atomos/texto.dart';

class FilaResumen extends StatelessWidget {
  final String label;
  final String valor;
  final bool isBold;
  final Color? color;

  const FilaResumen({
    super.key,
    required this.label,
    required this.valor,
    this.isBold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LabelText(
            text: label,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
          LabelText(
            text: valor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black87,
          ),
        ],
      ),
    );
  }
}
