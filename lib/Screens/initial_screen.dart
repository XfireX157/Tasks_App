import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:tasks_project/Components/task.dart';
import 'package:tasks_project/Data/task_dao.dart';
import 'package:tasks_project/Screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              if (items != null) {
                if (items.isNotEmpty) {
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Task tasks = items[index];
                        return Task(
                          tasks.nome,
                          tasks.foto,
                          tasks.dificuldade,
                          onTaskDeleted: () {
                            setState(() {}); // Atualiza a tela após a exclusão da tarefa
                          },
                        );
                      });
                }
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 128),
                      Text('Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 22))
                    ],
                  ),
                );
              }
              return Text('Erro');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => FormScreen(taskContent: context),
              ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
