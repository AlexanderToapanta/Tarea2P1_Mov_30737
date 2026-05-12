import 'package:flutter/material.dart';
import '../atomos/texto.dart';
import '../atomos/checkbox.dart';

class OpcionesAdicionales extends StatelessWidget {
  final bool tieneDiscapacidad;
  final bool esTerceraEdad;
  final bool pagoOportuno;
  final Function(bool?) onDiscapacidadChanged;
  final Function(bool?) onTerceraEdadChanged;
  final Function(bool?) onPagoOportunoChanged;

  const OpcionesAdicionales({
    super.key,
    required this.tieneDiscapacidad,
    required this.esTerceraEdad,
    required this.pagoOportuno,
    required this.onDiscapacidadChanged,
    required this.onTerceraEdadChanged,
    required this.onPagoOportunoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(
          text: 'Opciones adicionales:',
          fontWeight: FontWeight.bold,
        ),
        CustomCheckbox(
          label: 'Discapacidad',
          value: tieneDiscapacidad,
          onChanged: onDiscapacidadChanged,
        ),
        CustomCheckbox(
          label: 'Tercera Edad',
          value: esTerceraEdad,
          onChanged: onTerceraEdadChanged,
        ),
        CustomCheckbox(
          label: 'Pago Oportuno',
          value: pagoOportuno,
          onChanged: onPagoOportunoChanged,
        ),
      ],
    );
  }
}
