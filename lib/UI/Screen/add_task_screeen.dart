import 'package:flutter/material.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/model_add_tasks.dart';
import 'package:to_do_list_rxdart/UI/Screen/model_tasks_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task? task;
  final ModelTaskDetail model;
  final ModelTasks modelTasks;


  TaskDetailScreen({Key? key, this.task, required this.modelTasks})
      : model = ModelTaskDetail(task, ModelTasks()), // Передаем экземпляр ModelTasks
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Описание задачи'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: model.titleController,
                  decoration: InputDecoration(hintText: 'Название'),
                ),
                TextField(
                  maxLines: 25,
                  minLines: 5,
                  controller: model.descriptionController,
                  decoration: InputDecoration(hintText: 'Описание'),
                ),
                StreamBuilder<bool>(
                  stream: model.completedStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: snapshot.data,
                              onChanged: (value) {
                                model.updateCompleted(value!);
                              },
                            ),
                            Text('Выполнено'),
                          ],
                        ),
                        if (task != null) // Проверяем, редактируем ли существующую задачу
                          ElevatedButton(
                            onPressed: () {
                               model.deleteTask(modelTasks,task,context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: Text(
                              'Удалить запись',
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    model.saveTask(context);
                  },
                  child: Text('Сохранить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
