import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife2/tasks/blocs/tasks_bloc.dart';
import 'package:modulife2/tasks/tasks.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (BuildContext _) => TaskPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Todo app',
          profile: null,
          enableBackButton: true,
        ),
        body: BlocProvider(
          create: (context) => TasksBloc(),
          child: const TaskView(),
        )
        );
  }
}
