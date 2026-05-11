import 'package:flutter/material.dart';
import '../modelo/chofer_model.dart';
import '../controlador/chofer_controller.dart';
import '../widget/moleculas/formulario_chofer.dart';
import '../widget/atomos/botonPrimario.dart';
import '../widget/atomos/texto.dart';

class ChoferesSelectorView extends StatefulWidget {
  const ChoferesSelectorView({Key? key}) : super(key: key);

  @override
  State<ChoferesSelectorView> createState() => _ChoferesSelectorViewState();
}

class _ChoferesSelectorViewState extends State<ChoferesSelectorView> {
  final ControladorChoferes _controlador = ControladorChoferes();
  bool _mostrarFormulario = false;

  void _registrarChofer(String nombre, double sueldoPorHora, Map<String, double> horasPorDia) {
    setState(() {
      _controlador.agregarChofer(
        nombre: nombre,
        sueldoPorHora: sueldoPorHora,
        horasPorDia: horasPorDia,
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
                      onGuardar: (nombre, sueldo, horas) {
                        _registrarChofer(nombre, sueldo, horas);
                        setState(() {
                          _mostrarFormulario = false;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      label: 'Cancelar',
                      onPressed: () {
                        setState(() {
                          _mostrarFormulario = false;
                        });
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.close,
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              _buildResumenGeneral(),
              const SizedBox(height: 24),
              _buildListaChoferes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResumenGeneral() {
    final choferMasHoras = _controlador.choferConMasHorasLunes;

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
                _controlador.choferes.length.toString(),
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
                '\$${_controlador.totalSueldos.toStringAsFixed(2)}',
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

  Widget _buildListaChoferes() {
    if (_controlador.choferes.isEmpty) {
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
          itemCount: _controlador.choferes.length,
          itemBuilder: (context, index) {
            final chofer = _controlador.choferes[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chofer.nombre,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _eliminarChofer(chofer.id);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sueldo/hora:'),
                              Text(
                                '\$${chofer.sueldoPorHora.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Horas semanales:'),
                              Text(
                                '${chofer.horasSemanales} hrs',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sueldo semanal:'),
                              Text(
                                '\$${chofer.sueldoTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ExpansionTile(
                      title: const Text('Horas por día'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey.shade50,
                          child: Column(
                            children: chofer.horasPorDia.entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${entry.key[0].toUpperCase()}${entry.key.substring(1)}:'),
                                    Text('${entry.value} hrs'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
