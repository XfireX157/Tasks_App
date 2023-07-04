import 'package:flutter/material.dart';
import 'package:tasks_project/Data/task_dao.dart';
import 'dificuty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  final VoidCallback? onTaskDeleted;

  const Task(this.nome, this.foto, this.dificuldade, {super.key, this.onTaskDeleted});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;

  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(6)),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(6)),
                      width: 90,
                      height: 100,
                      child: assetOrNetwork()
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child:
                                  Image.asset(widget.foto, fit: BoxFit.cover))
                          : Image.network(widget.foto, fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis)),
                          Difficuty(dificutyLevel: widget.dificuldade)
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nivel++;
                              });
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_drop_up),
                                Text('Lvl Up'),
                              ],
                            )))
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                    Text(
                      'Nivel $nivel',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: -10,
            left: 0,
            child: ElevatedButton(
              onPressed: () async {
                await TaskDao().delete(widget.nome);
                setState(() {
                  if (widget.onTaskDeleted != null) {
                    widget.onTaskDeleted!(); // Chama a função de callback após a exclusão da tarefa
                  }
                });
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(30, 30)), // Define o tamanho mínimo do botão
                padding: MaterialStateProperty.all(EdgeInsets.zero), // Remove o espaçamento interno do botão
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduz o tamanho do hit area do botão
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
              ),
              child: const Text('x', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
