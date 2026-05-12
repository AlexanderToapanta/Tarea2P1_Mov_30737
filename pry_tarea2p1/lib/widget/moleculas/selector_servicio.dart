import 'package:flutter/material.dart';
import '../../modelo/servicio_model.dart';
import '../atomos/texto.dart';

class SelectorServicio extends StatelessWidget {
  final List<Servicio> servicios;
  final Servicio? seleccionado;
  final Function(Servicio?) onChanged;

  const SelectorServicio({
    super.key,
    required this.servicios,
    required this.seleccionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(
          text: 'Tipo de servicio:',
          fontWeight: FontWeight.bold,
        ),
        for (var servicio in servicios)
          RadioListTile<Servicio>(
            title: LabelText(text: servicio.nombre, fontWeight: FontWeight.normal),
            value: servicio,
            groupValue: seleccionado,
            onChanged: onChanged,
            activeColor: Colors.teal,
          ),
      ],
    );
  }
}
