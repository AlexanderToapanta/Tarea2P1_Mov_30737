import 'package:flutter/material.dart';
import '../atomos/text_field.dart';
import '../atomos/texto.dart';
import '../atomos/botonPrimario.dart';
import '../atomos/inputDecimal.dart';

class FormularioChofer extends StatefulWidget {
  final Function(String nombre, double sueldoPorHora, Map<String, double> horasPorDia, bool tieneBono, String horario) onGuardar;
  final VoidCallback onCancelar;
  final bool esEdicion;

  const FormularioChofer({
    Key? key,
    required this.onGuardar,
    required this.onCancelar,
    this.esEdicion = false,
  }) : super(key: key);

  @override
  State<FormularioChofer> createState() => _FormularioChofersState();
}

class _FormularioChofersState extends State<FormularioChofer> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _sueldoController = TextEditingController();

  final Map<String, TextEditingController> _horasControllers = {
    'lunes': TextEditingController(text: '0'),
    'martes': TextEditingController(text: '0'),
    'miercoles': TextEditingController(text: '0'),
    'jueves': TextEditingController(text: '0'),
    'viernes': TextEditingController(text: '0'),
    'sabado': TextEditingController(text: '0'),
  };

  final List<String> _diasSemana = [
    'lunes',
    'martes',
    'miercoles',
    'jueves',
    'viernes',
    'sabado'
  ];

  bool _tieneBono = false;
  String _horario = 'mañana';

  @override
  void dispose() {
    _nombreController.dispose();
    _sueldoController.dispose();
    for (var c in _horasControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final Map<String, double> horas = {};
      for (var dia in _diasSemana) {
        horas[dia] = double.tryParse(_horasControllers[dia]?.text ?? '0') ?? 0;
      }

      widget.onGuardar(
        _nombreController.text,
        double.parse(_sueldoController.text),
        horas,
        _tieneBono,
        _horario,
      );

      _nombreController.clear();
      _sueldoController.clear();
      for (var dia in _diasSemana) {
        _horasControllers[dia]?.text = '0';
      }
      setState(() {
        _tieneBono = false;
        _horario = 'mañana';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.esEdicion ? 'Chofer actualizado' : 'Chofer registrado',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _limpiar() {
    _nombreController.clear();
    _sueldoController.clear();
    for (var dia in _diasSemana) {
      _horasControllers[dia]?.text = '0';
    }
    setState(() {
      _tieneBono = false;
      _horario = 'mañana';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulario limpiado'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const LabelText(
            text: 'Datos del Chofer',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Nombre del Chofer',
            hintText: 'Ej: Chris Redfield',
            controller: _nombreController,
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre del chofer';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          InputDecimal(
            text: 'Sueldo por Hora',
            controller: _sueldoController,
          ),
          const SizedBox(height: 24),
          const LabelText(
            text: 'Horas por Día',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _diasSemana.length,
            itemBuilder: (context, index) {
              final dia = _diasSemana[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: LabelText(
                        text: '${dia[0].toUpperCase()}${dia.substring(1)}:',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _horasControllers[dia]!,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Horas',
                          hintText: '0',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Requerido';
                          }
                          final horas = double.tryParse(value);
                          if (horas == null) {
                            return 'Debe ser un número';
                          }
                          if (horas < 0 || horas > 12) {
                            return 'Entre 0 y 12';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 40,
                      child: Text(
                        'hrs',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const LabelText(
            text: 'Opciones Adicionales',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: _tieneBono,
                onChanged: (value) {
                  setState(() {
                    _tieneBono = value ?? false;
                  });
                },
              ),
              const Text('Recibe Bono'),
            ],
          ),
          const SizedBox(height: 12),
          const LabelText(
            text: 'Horario de Trabajo',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Mañana'),
                  value: 'mañana',
                  groupValue: _horario,
                  onChanged: (value) {
                    setState(() {
                      _horario = value ?? 'mañana';
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Noche'),
                  value: 'noche',
                  groupValue: _horario,
                  onChanged: (value) {
                    setState(() {
                      _horario = value ?? 'mañana';
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: widget.esEdicion ? 'Actualizar' : 'Registrar Chofer',
                      onPressed: _guardar,
                      backgroundColor: Colors.green,
                      icon: Icons.save,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: 'Limpiar',
                      onPressed: _limpiar,
                      backgroundColor: Colors.orange,
                      icon: Icons.clear,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label: 'Salir',
                      onPressed: widget.onCancelar,
                      backgroundColor: Colors.red,
                      icon: Icons.close,
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

