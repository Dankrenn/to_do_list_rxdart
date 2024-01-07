import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/add_task_screeen.dart';
import 'package:to_do_list_rxdart/UI/Screen/tasks_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Обязательно для инициализации Flutter

  // Инициализация shared_preferences
  await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(),
    );
  }
}
