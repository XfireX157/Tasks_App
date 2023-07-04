import 'package:flutter/material.dart';
import 'package:tasks_project/Data/initial_screen.dart';
import 'package:tasks_project/Screens/form_screen.dart';
import 'Screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TaskInherited(child: const InitialScreen()),
    );
  }
}
