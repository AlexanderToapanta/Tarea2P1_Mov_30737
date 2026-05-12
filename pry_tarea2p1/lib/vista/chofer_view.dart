import 'package:flutter/material.dart';
import '../modelo/chofer_model.dart';
import '../controlador/chofer_controller.dart';
import '../widget/moleculas/formulario_chofer.dart';
import '../widget/atomos/botonPrimario.dart';
import '../widget/atomos/texto.dart';
import '../widget/organismos/resumen_general.dart';
import '../widget/organismos/lista_choferes.dart';

class ChoferesSelectorView extends StatefulWidget {
  const ChoferesSelectorView({Key? key}) : super(key: key);

  @override
  State<ChoferesSelectorView> createState() => _ChoferesSelectorViewState();
}

class _ChoferesSelectorViewState extends State<ChoferesSelectorView> {
  final ControladorChoferes _controlador = ControladorChoferes();
  bool _mostrarFormulario = false;

  void _registrarChofer(String nombre, double sueldoPorHora, Map<String, double> horasPorDia, bool tieneBono, String horario) {
    setState(() {
      _controlador.agregarChofer(
        nombre: nombre,
        sueldoPorHora: sueldoPorHora,
        horasPorDia: horasPorDia,
        tieneBono: tieneBono,
        horario: horario,
      );
    });
  }

  void _eliminarChofer(int id) {
    setState(() {
      _controlador.eliminarChofer(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Choferes'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_mostrarFormulario)
                CustomButton(
                  label: 'Nuevo Registro',
                  onPressed: () {
                    setState(() {
                      _mostrarFormulario = true;
                    });
                  },
                  backgroundColor: Colors.teal,
                  icon: Icons.add,
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormularioChofer(
                      onGuardar: (nombre, sueldo, horas, tieneBono, horario) {
                        _registrarChofer(nombre, sueldo, horas, tieneBono, horario);
                        setState(() {
                          _mostrarFormulario = false;
                        });
                      },
                      onCancelar: () {
                        setState(() {
                          _mostrarFormulario = false;
                        });
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              ResumenGeneral(controlador: _controlador),
              const SizedBox(height: 24),
              ListaChoferes(
                controlador: _controlador,
                onEliminarChofer: _eliminarChofer,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
