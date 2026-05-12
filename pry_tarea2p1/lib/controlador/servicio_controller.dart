import '../modelo/servicio_model.dart';

class ServicioController {

  final List<Servicio> servicios = [
    Servicio('Agua Potable', 0.50),
    Servicio('Energía Eléctrica', 0.12),
    Servicio('Internet y Telefonía', 25.0),
    Servicio('TV por Cable', 30.0),
    Servicio('Otros Pagos', 10.0),
  ];


  String? validarCliente(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingrese el nombre del cliente';
    }

    if (value.trim().length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }

    return null;
  }


  String? validarServicio(Servicio? value) {
    if (value == null) {
      return 'Seleccione un servicio';
    }
    return null;
  }

  String? validarConsumo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingrese el consumo';
    }

    final numero = double.tryParse(value);

    if (numero == null) {
      return 'Ingrese un número válido';
    }

    if (numero <= 0) {
      return 'El consumo debe ser mayor a 0';
    }

    return null;
  }

}