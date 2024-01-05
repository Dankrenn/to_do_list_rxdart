import 'package:flutter/material.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/add_task_screeen.dart';
import 'package:to_do_list_rxdart/UI/Screen/tasks_screen.dart';


void main() {
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
