import 'package:flutter/material.dart';
import '../atomos/botonPrimario.dart';

class MenuEjercicios extends StatelessWidget {
  const MenuEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          label: 'Problema 1',
          onPressed: () => Navigator.pushNamed(context, '/problema1'),
          backgroundColor: Colors.blue,
        ),
        const SizedBox(height: 10),
        CustomButton(
          label: 'Problema 2',
          onPressed: () => Navigator.pushNamed(context, '/problema2'),
          backgroundColor: Colors.green,
        ),
        
      ],
    );
  }
}
