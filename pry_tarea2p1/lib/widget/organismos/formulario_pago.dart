import 'package:flutter/material.dart';
import '../../modelo/servicio_model.dart';
import '../moleculas/selector_servicio.dart';
import '../moleculas/opciones_adicionales.dart';
import '../atomos/inputTexto.dart';
import '../atomos/inputDecimal.dart';
import '../atomos/botonPrimario.dart';
import '../atomos/texto.dart';

class FormularioPago extends StatefulWidget {
  final List<Servicio> servicios;
  final Function(PagoServicio) onNavegar;

  const FormularioPago({
    super.key,
    required this.servicios,
    required this.onNavegar,
  });

  @override
  State<FormularioPago> createState() => _FormularioPagoState();
}

class _FormularioPagoState extends State<FormularioPago> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _consumo = TextEditingController();
  
  Servicio? _seleccionado;
  bool _disc = false;
  bool _edad = false;
  bool _oportuno = true;
  double _total = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTexto(text: 'Nombre del Cliente', controller: _nombre),
        const SizedBox(height: 16),
        InputDecimal(text: 'Consumo o Valor Base', controller: _consumo),
        const SizedBox(height: 20),
        SelectorServicio(
          servicios: widget.servicios,
          seleccionado: _seleccionado,
          onChanged: (val) => setState(() => _seleccionado = val),
        ),
        const SizedBox(height: 10),
        OpcionesAdicionales(
          tieneDiscapacidad: _disc,
          esTerceraEdad: _edad,
          pagoOportuno: _oportuno,
          onDiscapacidadChanged: (val) => setState(() => _disc = val!),
          onTerceraEdadChanged: (val) => setState(() => _edad = val!),
          onPagoOportunoChanged: (val) => setState(() => _oportuno = val!),
        ),
        const SizedBox(height: 20),
        if (_total > 0)
          LabelText(
            text: 'Subtotal a pagar: \$${_total.toStringAsFixed(2)}',
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              label: 'Calcular',
              onPressed: () {
                setState(() {
                  if (_seleccionado != null) {
                    final p = PagoServicio(
                      consumo: double.tryParse(_consumo.text) ?? 0,
                      servicio: _seleccionado,
                      discapacidad: _disc,
                      terceraEdad: _edad,
                      pagoOportuno: _oportuno,
                    );
                    _total = p.total;
                  }
                });
              },
            ),
            CustomButton(
              label: 'Limpiar',
              backgroundColor: Colors.grey,
              onPressed: () {
                setState(() {
                  _nombre.clear();
                  _consumo.clear();
                  _seleccionado = null;
                  _disc = false;
                  _edad = false;
                  _oportuno = true;
                  _total = 0;
                });
              },
            ),
            CustomButton(
              label: 'Resumen de pago',
              backgroundColor: Colors.orange,
              onPressed: () {
                if (_nombre.text.isNotEmpty && _seleccionado != null) {
                  final pago = PagoServicio(
                    cliente: _nombre.text,
                    consumo: double.tryParse(_consumo.text) ?? 0,
                    servicio: _seleccionado,
                    discapacidad: _disc,
                    terceraEdad: _edad,
                    pagoOportuno: _oportuno,
                  );
                  widget.onNavegar(pago);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
