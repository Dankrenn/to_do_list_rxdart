import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';

class TaskDetailModel {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final BehaviorSubject<bool> _completedSubject;

  TaskDetailModel(Task? task)
      : _completedSubject = BehaviorSubject<bool>.seeded(task?.completed ?? false),
        titleController = TextEditingController(text: task?.title ?? ''),
        descriptionController = TextEditingController(text: task?.description ?? '');

  Stream<bool> get completedStream => _completedSubject.stream;

  bool get completed => _completedSubject.value ?? false;

  void updateCompleted(bool value) {
    _completedSubject.add(value);
  }

  void saveTask(BuildContext context) {
    final updatedTask = Task(
      description: descriptionController.text,
      title: titleController.text,
      completed: completed,
    );

    Navigator.pop(context, updatedTask);
  }

  void dispose() {
    _completedSubject.close();
  }
}