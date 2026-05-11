import 'package:flutter/material.dart';

class IntegrantesCard extends StatelessWidget {
  final List<String> integrantes;

  const IntegrantesCard({super.key, required this.integrantes});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Integrantes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...integrantes.map((nombre) => Text(
                  nombre,
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
