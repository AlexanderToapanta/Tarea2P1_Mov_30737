import '../modelo/servicio_model.dart';

class ServicioController {
  final List<Servicio> servicios = [
    Servicio('Agua Potable', 0.50),
    Servicio('Energía Eléctrica', 0.12),
    Servicio('Internet y Telefonía', 25.0),
    Servicio('TV por Cable', 30.0),
    Servicio('Otros Pagos', 10.0),
  ];

  String? validarNombre(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese el nombre del cliente';
    return null;
  }

  String? validarConsumo(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese el consumo';
    if (double.tryParse(value) == null) return 'Ingrese un valor numérico';
    return null;
  }
}
