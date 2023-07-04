import 'package:sqflite/sqflite.dart';
import 'package:tasks_project/Components/task.dart';
import 'package:tasks_project/Data/database.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  Map<String, dynamic> toMap(Task tarefa) {
    Map<String, dynamic> mapTask = Map();
    mapTask[_name] = tarefa.nome;
    mapTask[_image] = tarefa.foto;
    mapTask[_difficulty] = tarefa.dificuldade;
    return mapTask;
  }

  save(Task tarefa) async {
    final Database bancoDeDados = await getDatabase();
    var itemExist = await findName(tarefa.nome);
    Map<String, dynamic> mapTask = toMap(tarefa);
    if (!itemExist.isEmpty) {
      return await bancoDeDados.update(_tablename, mapTask,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
    return await bancoDeDados.insert(_tablename, mapTask);
  }

  Future<List<Task>> findAll() async {
    print('estamos acessando o findAll');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapList) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapList) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<Task>> findName(String nameTask) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nameTask]);
    return toList(result);
  }

  delete(String nameTask) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_tablename, where: '$_name = ?', whereArgs: [nameTask]);
  }
}
