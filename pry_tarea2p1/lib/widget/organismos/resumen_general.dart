import 'package:flutter/material.dart';
import '../../modelo/chofer_model.dart';
import '../../controlador/chofer_controller.dart';
import '../atomos/texto.dart';

class ResumenGeneral extends StatelessWidget {
  final ControladorChoferes controlador;

  const ResumenGeneral({
    Key? key,
    required this.controlador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choferMasHoras = controlador.choferConMasHorasLunes;

    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal, width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelText(
            text: 'Resumen General',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total de Choferes:'),
              Text(
                controlador.choferes.length.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total a Pagar:'),
              Text(
                '\$${controlador.totalSueldos.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (choferMasHoras != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'Chofer con más horas el lunes:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      choferMasHoras.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      '${choferMasHoras.horasLunes} hrs',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
