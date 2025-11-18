 // ignore: depend_on_referenced_packages
 import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class TarefaFormPage extends StatefulWidget {
  const TarefaFormPage({super.key});

  @override
  State<TarefaFormPage> createState() => _TarefaFormPageState();
}

class _TarefaFormPageState extends State<TarefaFormPage> {
  late TextEditingController controllerDescricao;
  late TextEditingController controllerTitulo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
      appBar: AppBar(title:Text("Cadastrar Tarefa"),),
      body: Form(
        key: formKey,
        child: Column(
         children: [
          Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controllerTitulo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite uma título para a tarefa',
                      ),
                      validator: (value) => _validaCampoTitulo(),
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
                      validator: (value) => _validaCampoTitulo(),
                    ),
                  ),
                  ElevatedButton.icon(
                  onPressed: _salvarTarefa, 
                  label: Text("Salvar Tarefa"), 
                  icon: Icon(Icons.save_alt_outlined),
                  )
         ], 
            ),
      ),
    );
  }
  String? _validaCampoTitulo(){
    var titulo = controllerTitulo.text;
     if (titulo.trim().isEmpty) {
      return " Você precisa digitar um título! ";
     }    
  }
   Future<void>_salvarTarefa() async {
  
    var tituloTarefa = controllerTitulo.text; //INCLUIMOS
    var descricaoTarefa = controllerDescricao.text; //INCLUIMOS

    if(formKey.currentState?.validate() == true){
      //Salvar
var dio = Dio(
    BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: 'https://6912671052a60f10c8218d6e.mockapi.io',
      ),
    );

  var response = await dio.post(
    '/tarefa', data: {
      'titulo': tituloTarefa,
      'descricao': descricaoTarefa,
    }
  );

    if(context.mounted) Navigator.pop(context);

  }
    }

}
