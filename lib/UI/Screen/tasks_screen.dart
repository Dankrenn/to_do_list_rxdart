import 'package:flutter/material.dart';
import 'package:to_do_list_rxdart/Business%20logic/Task.dart';
import 'package:to_do_list_rxdart/UI/Screen/model_tasks_screen.dart';

class TaskScreen extends StatelessWidget {
  final ModelTasks model = ModelTasks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Задачи'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Task>>(
        stream: model.tasksStream,  //Подписка на стрим
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Нет задач'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final task = snapshot.data![index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                onTap: () {
                  model.NavigateToTaskDetailScreen(context,task,model);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.NavigateToTaskDetailScreen(context,null,model);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    model.dispose();
  }
}
