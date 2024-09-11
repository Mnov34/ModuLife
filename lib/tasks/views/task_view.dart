import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife2/tasks/blocs/tasks_bloc.dart';
import 'package:modulife2/tasks/tasks.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class TaskView extends StatelessWidget {
  TaskView({super.key});

  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add new task'),
            content: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Enter task title",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: UiColors.accentColor2,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    color: UiColors.dangerRed,
                  ),
                ),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final newTask = Task(
                    id: UniqueKey().toString(),
                    title: titleController.text,
                  );

                  context.read<TasksBloc>().add(AddTask(task: newTask));

                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {},
      child: Stack(
        children: [
          Container(
            color: UiColors.background,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(label: Text('Tasks:')),
              ),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (BuildContext context, TasksState state) {
                  if (state.status == TasksStatus.loading) {
                    return const CircularProgressIndicator();
                  } else if (state.status == TasksStatus.failure) {
                    return const Text('Failed to load tasks');
                  }

                  final List<Task> tasksList = state.allTasks;

                  return TasksList(taskList: tasksList);
                },
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: RawMaterialButton(
              onPressed: () => _addTask(
                  context) /*{
                final Task newTask = Task(id: UniqueKey().toString(), title: 'New task');
                context.read<TasksBloc>().add(AddTask(task: newTask));
              }*/
              ,
              child: const CircleAvatar(
                radius: 33,
                backgroundColor: UiColors.accentColor1,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: UiColors.accentColor2,
                  child: Icon(
                    Icons.add,
                    color: UiColors.accentColor1,
                    size: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
