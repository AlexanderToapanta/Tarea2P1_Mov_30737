import 'package:flutter/material.dart';
import '../../controlador/chofer_controller.dart';
import '../atomos/texto.dart';
import 'tarjeta_chofer.dart';

class ListaChoferes extends StatelessWidget {
  final ControladorChoferes controlador;
  final Function(int) onEliminarChofer;

  const ListaChoferes({
    Key? key,
    required this.controlador,
    required this.onEliminarChofer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controlador.choferes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Icon(
                Icons.person_off,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'Sin choferes registrados',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(
          text: 'Choferes Registrados',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controlador.choferes.length,
          itemBuilder: (context, index) {
            final chofer = controlador.choferes[index];
            return TarjetaChofer(
              chofer: chofer,
              onEliminar: () => onEliminarChofer(chofer.id),
            );
          },
        ),
      ],
    );
  }
}
