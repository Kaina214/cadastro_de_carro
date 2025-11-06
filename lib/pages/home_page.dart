
import 'package:flutter/material.dart';

import '../models/tarefa_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.subtitulo});

  final String title;
  final String subtitulo;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tarefa> tarefas = [];
  late TextEditingController controllerDescricao;
  late TextEditingController controllerTitulo;
  @override
  void initState() {
    controllerTitulo = TextEditingController();
    controllerDescricao = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerTitulo.dispose();
    controllerDescricao.dispose();
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
            
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerTitulo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite uma título para a tarefa',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerDescricao,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite uma Descrição para a tarefa',
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(tarefas[index].titulo),
                  subtitle: Text(tarefas[index].descricao),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarTarefa,

        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarTarefa() {
    var tituloTarefa = controllerTitulo.text;
    var descricaoTarefa = controllerDescricao.text;

    if (tituloTarefa.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" Você precisa digitar um título! ")),
      );
      return;
    }
    if (descricaoTarefa.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" Você precisa digitar uma descrição! ")),
      );
      return;
    }
    var tarefa = Tarefa(descricao: descricaoTarefa, titulo: tituloTarefa);
    setState(() {
      tarefas.add(tarefa);
    });
    controllerDescricao.clear();
    controllerTitulo.clear();
  }
}
