import 'package:flutter/material.dart';
import 'package:tasks_project/Components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    const Task(
        'Aprender fluter',
        'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
        4),
    const Task(
        'Aprender fluterasdadasdda',
        'assets/images/dados.jpg',
        2),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
