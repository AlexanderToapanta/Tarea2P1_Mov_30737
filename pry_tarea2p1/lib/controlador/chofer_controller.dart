import '../modelo/chofer_model.dart';

class ControladorChoferes {
  final List<Chofer> _choferes = [];
  int _nextId = 1;

  ControladorChoferes() {
    _inicializarChoferes();
  }

  void _inicializarChoferes() {
    agregarChofer(
      nombre: 'Chris Redfield',
      sueldoPorHora: 15.50,
      horasPorDia: {
        'lunes': 8,
        'martes': 7,
        'miercoles': 8,
        'jueves': 7,
        'viernes': 8,
        'sabado': 6,
        'domingo': 0,
      },
    );

    agregarChofer(
      nombre: 'Jill Valentine',
      sueldoPorHora: 16.00,
      horasPorDia: {
        'lunes': 9,
        'martes': 8,
        'miercoles': 8,
        'jueves': 8,
        'viernes': 7,
        'sabado': 5,
        'domingo': 0,
      },
    );

    agregarChofer(
      nombre: 'Leon S. Kennedy',
      sueldoPorHora: 14.75,
      horasPorDia: {
        'lunes': 7,
        'martes': 8,
        'miercoles': 7,
        'jueves': 8,
        'viernes': 8,
        'sabado': 6,
        'domingo': 4,
      },
    );

    agregarChofer(
      nombre: 'Ada Wong',
      sueldoPorHora: 18.50,
      horasPorDia: {
        'lunes': 6,
        'martes': 7,
        'miercoles': 6,
        'jueves': 7,
        'viernes': 6,
        'sabado': 5,
        'domingo': 0,
      },
    );

    agregarChofer(
      nombre: 'Claire Redfield',
      sueldoPorHora: 15.00,
      horasPorDia: {
        'lunes': 8,
        'martes': 8,
        'miercoles': 9,
        'jueves': 8,
        'viernes': 8,
        'sabado': 7,
        'domingo': 2,
      },
    );
  }

  List<Chofer> get choferes => List.unmodifiable(_choferes);

  double _redondear(double valor) {
    return (valor * 100).roundToDouble() / 100;
  }

  void agregarChofer({
    required String nombre,
    required double sueldoPorHora,
    required Map<String, double> horasPorDia,
  }) {
    _choferes.add(
      Chofer(
        id: _nextId++,
        nombre: nombre,
        sueldoPorHora: _redondear(sueldoPorHora),
        horasPorDia: Map.from(horasPorDia),
      ),
    );
  }

  bool actualizarChofer({
    required int id,
    required String nombre,
    required double sueldoPorHora,
    required Map<String, double> horasPorDia,
  }) {
    final index = _choferes.indexWhere((chofer) => chofer.id == id);
    if (index == -1) {
      return false;
    }

    _choferes[index]
      ..nombre = nombre
      ..sueldoPorHora = _redondear(sueldoPorHora)
      ..horasPorDia = Map.from(horasPorDia);

    return true;
  }

  bool eliminarChofer(int id) {
    final cantidadInicial = _choferes.length;
    _choferes.removeWhere((chofer) => chofer.id == id);
    return _choferes.length < cantidadInicial;
  }

  double get totalSueldos {
    return _redondear(_choferes.fold(0, (sum, chofer) => sum + chofer.sueldoTotal));
  }

  Chofer? get choferConMasHorasLunes {
    if (_choferes.isEmpty) return null;
    return _choferes.reduce((actual, siguiente) =>
        actual.horasLunes >= siguiente.horasLunes ? actual : siguiente);
  }

  double getTotalHorasSemanal(int id) {
    final chofer = _choferes.firstWhere((c) => c.id == id, orElse: () => Chofer(
      id: -1,
      nombre: '',
      sueldoPorHora: 0,
    ));
    return chofer.horasSemanales;
  }
}
