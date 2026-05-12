class Servicio {
  String nombre;
  double tarifa;

  Servicio(this.nombre, this.tarifa);
}

class PagoServicio {
  String cliente;
  Servicio? servicio;
  double consumo;
  bool discapacidad;
  bool terceraEdad;
  bool pagoOportuno;

  PagoServicio({
    this.cliente = '',
    this.servicio,
    this.consumo = 0,
    this.discapacidad = false,
    this.terceraEdad = false,
    this.pagoOportuno = true,
  });

  double get subtotal => (servicio?.tarifa ?? 0) * consumo;

  double get totalDescuento {
    double d = 0;
    if (discapacidad) d += subtotal * 0.10;
    if (terceraEdad) d += subtotal * 0.05;
    return d;
  }

  double get totalRecargo => pagoOportuno ? 0 : subtotal * 0.02;

  double get total => subtotal - totalDescuento + totalRecargo;
}
