import 'package:flutter/material.dart';
import 'package:modulife2/tasks/tasks.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (BuildContext context, int index) {
            Task task = taskList[index];
            return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (bool? value) {},
              ),
            );
          },
        ));
  }
}