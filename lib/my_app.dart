import 'package:cadastro_de_carro/main.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Primeiro App Flutter',
      home: Scaffold(
        appBar: AppBar(title: Text('Meu Primeiro App Flutter')),
        body: MyHomePage(title: "Primeiro App"),
      ),
    );
  }
}
