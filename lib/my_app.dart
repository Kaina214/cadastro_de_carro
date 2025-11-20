import 'package:cadastro_de_carro/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.black, useMaterial3: true),
      home: MyHomePage(title: "Primeiro App", subtitulo: "Cadastro de Carros"),
    );
  }
}
