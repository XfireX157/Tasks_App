import 'package:flutter/material.dart';
import '../Components/task.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() =>
      _InitialScreenState(

      );
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: const [
            Task(
                'Aprender fluter',
                'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
                4),
            Task(
                'Aprender fluterasdadasdda',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKGlU4XEm_dRp4kfWljB_v1EAGz58yZbJ7WsdvBjk&s',
                2),
            SizedBox(height: 80)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}