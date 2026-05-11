import 'package:flutter/material.dart';
import '../atomos/botonPrimario.dart';

class MenuEjercicios extends StatelessWidget {
  const MenuEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          text: 'Problema 1',
          onPressed: () => Navigator.pushNamed(context, '/problema1'),
        ),
        const SizedBox(height: 10),
        PrimaryButton(
          text: 'Problema 2',
          onPressed: () => Navigator.pushNamed(context, '/problema2'),
        ),
        
      ],
    );
  }
}
