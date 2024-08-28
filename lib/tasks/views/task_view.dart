import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife2/tasks/blocs/tasks_bloc.dart';
import 'package:modulife2/tasks/tasks.dart';
import 'package:modulife2/uikit/uicolors.dart';

class TaskView extends StatelessWidget{
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
        listener: (context, state) {
        },
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
                    if(state.status == TasksStatus.loading) {
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
              onPressed: () {},
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