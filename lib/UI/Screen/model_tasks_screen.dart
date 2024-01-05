import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/add_task_screeen.dart';


class ModelTasks {
  final BehaviorSubject<List<Task>> _tasksController = BehaviorSubject<
      List<Task>>();
  List<Task> _tasks = [];

  Stream<List<Task>> get tasksStream => _tasksController.stream;

  void addTask(Task task) {
    _tasks.add(task);
    _tasksController.add(_tasks);
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.title == updatedTask.title);
    if (index != -1) {
      _tasks[index] = updatedTask;
      _tasksController.add(_tasks);
    }
  }

  void dispose() {
    _tasksController.close();
  }

  void NavigateToTaskDetailScreen(BuildContext context, Task? task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );

    if (updatedTask != null) {
      if (task != null) {
        updateTask(updatedTask);
      } else {
        addTask(updatedTask);
      }
    }
  }

  void SaveTask(TextEditingController title, TextEditingController description, bool completed, BuildContext context) {
    final updatedTask = Task(
      description: description.text,
      title: title.text,
      completed: completed,
    );

    Navigator.pop(context, updatedTask);
  }

}