import 'package:flutter/material.dart';
import '../widget/moleculas/integrantesCard.dart';
import '../widget/moleculas/menuEjercicios.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidad de las Fuerzas Armadas "ESPE"'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Tarea 1.2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const IntegrantesCard(
              integrantes: [
                'Erick Obando',
                'Alexander Topanta',
                'Alison Ayo',
                'Josue Solano',
              ],
            ),
            const SizedBox(height: 30),
            const MenuEjercicios(),
          ],
        ),
      ),
    );
  }
}
