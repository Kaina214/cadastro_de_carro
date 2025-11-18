import 'package:cadastro_de_carro/pages/tarefa_form_page.dart';
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
  List<Tarefa> tarefas = [];

  bool isLoading = false;

  @override
  void initState() {
    _getTarefas();

    super.initState();
  }

  Future<void> _getTarefas() async {
    setState(() {
      isLoading = true;
    });

    var dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: 'https://6912665e52a60f10c8218aa2.mockapi.io/api/v1',
      ),
    );
    var response = await dio.get('/tarefa');
    var listaData = response.data as List;

    for (var data in listaData) {
      var tarefa = Tarefa(
        titulo: data['titulo'],
        descricao: data['descricao'],
        data: '',
      );
      tarefas.add(tarefa);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarTarefa,

        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarTarefa() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TarefaFormPage();
        },
      ),
    ).then((_) {
      setState(() {
        tarefas.clear();
        _getTarefas();
      });

   
    // }
    // var tarefa = Tarefa(descricao: descricaoTarefa, titulo: tituloTarefa, data: '');
    // setState(() {
    //   tarefas.add(tarefa);
    // });
    // controllerDescricao.clear();
    // controllerTitulo.clear();
  }
    );
  }
}

class   SubttituloWidget extends StatelessWidget {
  final String label;

  const SubttituloWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
    );
  }
  
}

class   Tarefa {
  String titulo;
  String descricao;
  String data;

  Tarefa({
    required this.titulo,
    required this.descricao,
    required this.data,
  });
}