class Chofer {
  final int id;
  String nombre;
  double sueldoPorHora;
  Map<String, double> horasPorDia;
  bool tieneBono;
  String horario; 

  Chofer({
    required this.id,
    required this.nombre,
    required this.sueldoPorHora,
    Map<String, double>? horasPorDia,
    this.tieneBono = false,
    this.horario = 'mañana',
  }) : horasPorDia = horasPorDia ?? {
    'lunes': 0,
    'martes': 0,
    'miercoles': 0,
    'jueves': 0,
    'viernes': 0,
    'sabado': 0,
  };

  double get horasSemanales {
    final keys = ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado'];
    return keys.fold(0.0, (sum, k) => sum + (horasPorDia[k] ?? 0));
  }

  double _redondear(double valor) {
    return (valor * 100).roundToDouble() / 100;
  }

  double get sueldoTotal => _redondear(horasSemanales * sueldoPorHora);

  double get horasLunes => horasPorDia['lunes'] ?? 0;
}
