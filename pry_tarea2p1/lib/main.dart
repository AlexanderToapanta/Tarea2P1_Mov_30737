import 'package:flutter/material.dart';
import 'vista/principal.dart';
import 'vista/chofer_view.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea 2.1 - ESPE',
      initialRoute: '/',
      routes: {
        '/': (context) => const MainView(),
        '/problema1': (context) => const Scaffold(body: Center(child: Text('Problema 1'))),
        // Rutas definidas en MenuEjercicios (Pendientes de implementación)
        '/problema2': (context) => const ChoferesSelectorView(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}
