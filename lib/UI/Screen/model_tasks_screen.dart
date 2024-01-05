import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/add_task_screeen.dart';

// Класс для управления списком задач
class ModelTasks {
  // BehaviorSubject для потока списка задач
  final BehaviorSubject<List<Task>> _tasksController = BehaviorSubject<List<Task>>();
  List<Task> _tasks = []; // Локальное хранение списка задач

  // Поток, который может быть прослушан для получения списка задач
  Stream<List<Task>> get tasksStream => _tasksController.stream;

  // Метод для добавления новой задачи в список
  void addTask(Task task) {
    _tasks.add(task);
    _tasksController.add(_tasks);
  }

  // Метод для обновления существующей задачи в списке
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.title == updatedTask.title);
    if (index != -1) {
      _tasks[index] = updatedTask;
      _tasksController.add(_tasks);
    }
  }


  // Метод для освобождения ресурсов BehaviorSubject
  void dispose() {
    _tasksController.close();
  }

  // Метод для перехода к экрану деталей задачи и обновления списка после возврата
  void NavigateToTaskDetailScreen(BuildContext context, Task? task, ModelTasks modelTasks) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task, modelTasks: modelTasks,)),
    );

    if (updatedTask != null) {
      if (task != null) {
        updateTask(updatedTask);
      } else {
        addTask(updatedTask);
      }
    }
  }

  void deleteTask(Task? task) {
    _tasks.remove(task); // Предположим, что у вас есть список задач _tasks.
    _tasksController.add(_tasks);
  }

}
