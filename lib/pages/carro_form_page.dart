import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarroFormPage extends StatefulWidget {
  const CarroFormPage({super.key, required String id});

  @override
  State<CarroFormPage> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  late TextEditingController controllerNome;
  late TextEditingController controllerFabricante;
  late TextEditingController controllerModelo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = true;

  @override
  void initState() {
    controllerNome = TextEditingController();
    controllerFabricante = TextEditingController();
    controllerModelo = TextEditingController();

    _iniciaForm();

    super.initState();
  }
   Future<void> _iniciaForm() async {
      if (widget.id != null){
        var dio = Dio(
          BaseOptions(
            connectTimeout: Duration(seconds: 30),
            baseUrl: 'https://6912665e52a60f10c8218aa2.mockapi.io/api/v1',
     
          ),
        );
        var response = await dio.get('/carro/${widget.id}');

        controllerFabricante.text = response.data['fabricante'];
        controllerModelo.text = response.data['modelo'];
        controllerNome.text = response.data['nome'];
      }

      setState(() {
        isLoading = false;
      });
  }

  @override
  void dispose() {
    controllerFabricante.dispose();
    controllerModelo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Carro")),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerNome,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite um nome para o carro',
                ),
                validator: (value) => _validaCampoNome(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerFabricante,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite a fabricante do carro',
                ),
                validator: (value) => _validaCampoFabricante(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerModelo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite o modelo do carro',
                ),
                validator: (value) => _validaCampoModelo(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _salvarCarro,
              label: Text("Salvar Carro"),
              icon: Icon(Icons.save_alt_outlined),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: body_might_complete_normally_nullable
  String? _validaCampoFabricante() {
    var fabricante = controllerFabricante.text;
    if (fabricante.trim().isEmpty) {
      return " Você precisa digitar um fabricante! ";
    }
    return null;
  }

  String? _validaCampoModelo() {
    var modelo = controllerModelo.text;
    if (modelo.trim().isEmpty) {
      return " Você precisa digitar um modelo! ";
    }
    return null;
  }

  String? _validaCampoNome() {
    var nome = controllerNome.text;
    if (nome.trim().isEmpty) {
      return " Você precisa digitar um nome! ";
    }
    return null;
  }

  // ignore: unused_element
  Future<void> _salvarCarro() async {
    var nomeCarro = controllerNome.text;
    var fabricanteCarro = controllerFabricante.text; //INCLUIMOS
    var modeloCarro = controllerModelo.text; //INCLUIMOS

    if (formKey.currentState?.validate() == true) {
      //Salvar
      var dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 30),
          baseUrl: 'https://6912665e52a60f10c8218aa2.mockapi.io/api/v1',
        ),
      );

      // ignore: unused_local_variable
     var data = {'nome': nomeCarro, 'fabricante': fabricanteCarro, 'modelo': modeloCarro};

      if (widget.id != null) {
        await dio.put('/carro/${widget.id}', data: data);
      } else {
        await dio.post('/carro', data: data);
      }

      if (context.mounted) Navigator.pop(context);
    }
  }
}
