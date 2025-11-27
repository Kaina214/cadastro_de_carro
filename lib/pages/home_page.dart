import 'package:cadastro_de_carro/models/carro_model.dart';
import 'package:cadastro_de_carro/pages/carro_form_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.subtitulo});

  final String title;
  final String subtitulo;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Carro> carros = [];

  bool isLoading = false;

  @override
  void initState() {
    _getCarros();

    super.initState();
  }

  Future<void> _getCarros() async {
    setState(() {
      isLoading = true;
    });

    var dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: 'https://6912665e52a60f10c8218aa2.mockapi.io/api/v1',
      ),
    );
    var response = await dio.get('/carro');
    var listaData = response.data as List;

    for (var data in listaData) {
      var carro = Carro(
        nome: data['nome'],
        fabricante: data['fabricante'],
        modelo: data['modelo'],
      );
      carros.add(carro);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Row(
          children: [
            Text(widget.title),
            SizedBox(width: 8),
            SubttituloWidget(label: widget.subtitulo),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: carros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(carros[index].nome),
                  subtitle: Text(carros[index].fabricante),
                  trailing: Text(carros[index].modelo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarCarro,
        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarCarro() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) {
              return CarroFormPage();
            },
          ),
        )
        .then((_) {
          setState(() {
            carros.clear();
            _getCarros();
          });
        });
  }
}

class SubttituloWidget extends StatelessWidget {
  final String label;

  const SubttituloWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(fontSize: 14, color: Colors.white70));
  }
}
