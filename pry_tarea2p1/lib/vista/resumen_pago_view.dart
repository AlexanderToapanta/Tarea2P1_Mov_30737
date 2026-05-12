import 'package:flutter/material.dart';
import '../modelo/servicio_model.dart';
import '../widget/atomos/botonPrimario.dart';
import '../widget/atomos/texto.dart';
import '../widget/moleculas/fila_resumen.dart';

class ResumenPagoView extends StatelessWidget {
  const ResumenPagoView({super.key});

  @override
  Widget build(BuildContext context) {
    final PagoServicio pago = ModalRoute.of(context)!.settings.arguments as PagoServicio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Pago'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelText(
              text: 'Detalle de Facturación',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            const Divider(height: 30),
            FilaResumen(label: 'Cliente:', valor: pago.cliente),
            FilaResumen(label: 'Servicio:', valor: pago.servicio?.nombre ?? ''),
            FilaResumen(label: 'Consumo:', valor: pago.consumo.toStringAsFixed(2)),
            const Divider(),
            FilaResumen(label: 'Subtotal:', valor: '\$${pago.subtotal.toStringAsFixed(2)}'),
            FilaResumen(label: 'Descuentos:', valor: '-\$${pago.totalDescuento.toStringAsFixed(2)}'),
            FilaResumen(label: 'Recargos:', valor: '+\$${pago.totalRecargo.toStringAsFixed(2)}'),
            const Divider(thickness: 2),
            FilaResumen(
              label: 'TOTAL:',
              valor: '\$${pago.total.toStringAsFixed(2)}',
              isBold: true,
              color: Colors.green,
            ),
            const SizedBox(height: 40),
            Center(
              child: CustomButton(
                label: 'Volver',
                onPressed: () => Navigator.pop(context),
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
