import 'package:flutter/material.dart';
import '../controlador/servicio_controller.dart';
import '../widget/organismos/formulario_pago.dart';

class ServicioView extends StatefulWidget {
  const ServicioView({super.key});

  @override
  State<ServicioView> createState() => _ServicioViewState();
}

class _ServicioViewState extends State<ServicioView> {
  final ServicioController controlador = ServicioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos de Servicios'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormularioPago(
          servicios: controlador.servicios,
          onNavegar: (pago) {
            Navigator.pushNamed(context, '/resumen', arguments: pago);
          },
        ),
      ),
    );
  }
}
