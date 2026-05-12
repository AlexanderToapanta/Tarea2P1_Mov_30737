import 'package:flutter/material.dart';
import '../../modelo/servicio_model.dart';
import '../../controlador/servicio_controller.dart';
import '../moleculas/selector_servicio.dart';
import '../moleculas/opciones_adicionales.dart';
import '../atomos/inputTexto.dart';
import '../atomos/inputDecimal.dart'; // Para usar DecimalFormatter
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
  final _formKey = GlobalKey<FormState>();
  final _controller = ServicioController();
  
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _consumo = TextEditingController();
  
  Servicio? _seleccionado;
  bool _disc = false;
  bool _edad = false;
  bool _oportuno = true;
  double _total = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InputTexto(
              text: 'Nombre del Cliente', 
              controller: _nombre,
              validator: _controller.validarCliente,
            ),
            const SizedBox(height: 16),
            // Usamos InputTexto configurado como decimal ya que no podemos editar InputDecimal
            InputTexto(
              text: 'Consumo o Valor Base', 
              controller: _consumo,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [DecimalFormatter()],
              validator: _controller.validarConsumo,
            ),
            const SizedBox(height: 20),
            FormField<Servicio>(
              validator: (_) => _controller.validarServicio(_seleccionado),
              builder: (state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectorServicio(
                      servicios: widget.servicios,
                      seleccionado: _seleccionado,
                      onChanged: (val) {
                        setState(() => _seleccionado = val);
                        state.didChange(val);
                      },
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          state.errorText!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                );
              },
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
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        final p = PagoServicio(
                          consumo: double.tryParse(_consumo.text) ?? 0,
                          servicio: _seleccionado,
                          discapacidad: _disc,
                          terceraEdad: _edad,
                          pagoOportuno: _oportuno,
                        );
                        _total = p.total;
                      });
                    }
                  },
                ),
                CustomButton(
                  label: 'Limpiar',
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    _formKey.currentState!.reset();
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
                    if (_formKey.currentState!.validate()) {
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
        ),
      ),
    );
  }
}
