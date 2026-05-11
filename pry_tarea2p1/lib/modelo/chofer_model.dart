class Chofer {
  final int id;
  String nombre;
  double sueldoPorHora;
  Map<String, double> horasPorDia; 

  Chofer({
    required this.id,
    required this.nombre,
    required this.sueldoPorHora,
    Map<String, double>? horasPorDia,
  }) : horasPorDia = horasPorDia ?? {
    'lunes': 0,
    'martes': 0,
    'miercoles': 0,
    'jueves': 0,
    'viernes': 0,
    'sabado': 0,
    'domingo': 0,
  };

  double get horasSemanales {
    return horasPorDia.values.fold(0, (sum, horas) => sum + horas);
  }

  double _redondear(double valor) {
    return (valor * 100).roundToDouble() / 100;
  }

  double get sueldoTotal => _redondear(horasSemanales * sueldoPorHora);

  double get horasLunes => horasPorDia['lunes'] ?? 0;
}
