import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/model_tasks_screen.dart';

class ModelTaskDetail {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final BehaviorSubject<bool> _completedSubject;
  final ModelTasks modelTasks;
  // BehaviorSubject для управления потоком значения "Завершено"

  // Конструктор класса, принимающий объект задачи (Task) или null, если задача не существует
  ModelTaskDetail(Task? task, this.modelTasks)
      : _completedSubject = BehaviorSubject<bool>.seeded(task?.completed ?? false),
        titleController = TextEditingController(text: task?.title ?? ''),
        descriptionController = TextEditingController(text: task?.description ?? '');

  // Геттер для получения потока значений "Завершено"
  Stream<bool> get completedStream => _completedSubject.stream;

  // Геттер для получения текущего значения "Завершено"
  bool get completed => _completedSubject.value ?? false;

  // Метод для обновления значения "Завершено"
  void updateCompleted(bool value) {
    _completedSubject.add(value); // Добавление нового значения в поток
  }

  // Метод для сохранения задачи и возврата на предыдущий экран
  void saveTask(BuildContext context) {
    // Создание объекта Task с актуальными значениями из контроллеров и потока "Завершено"
    final updatedTask = Task(
      description: descriptionController.text,
      title: titleController.text,
      completed: completed,
    );

    // Закрытие текущего экрана и передача обновленной задачи на предыдущий экран
    Navigator.pop(context, updatedTask);
  }

  // Метод для освобождения ресурсов BehaviorSubject
  void dispose() {
    _completedSubject.close(); // Закрытие потока
  }

  void deleteTask(ModelTasks modelTasks, Task? task, BuildContext context) {
    // Вызовите метод удаления задачи в вашем классе ModelTasks.
    modelTasks.deleteTask(task);

    // После удаления задачи, закройте текущий экран.
    Navigator.pop(context);
  }


}
