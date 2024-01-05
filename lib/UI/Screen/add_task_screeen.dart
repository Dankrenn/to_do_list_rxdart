import 'package:flutter/material.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/model_add_tasks.dart';



class TaskDetailScreen extends StatelessWidget {
  final Task? task;
  final TaskDetailModel model;


  TaskDetailScreen({Key? key, this.task}) : model = TaskDetailModel(task), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Описание задачи'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: model.titleController,
              decoration: InputDecoration(hintText: 'Название'),
            ),
            TextField(
              controller: model.descriptionController,
              decoration: InputDecoration(hintText: 'Описание'),
            ),
            StreamBuilder<bool>(
              stream: model.completedStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return Checkbox(
                  value: snapshot.data,
                  onChanged: (value) {
                    model.updateCompleted(value!);
                  },
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
      ),
    );
  }
}

