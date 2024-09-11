import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife2/tasks/blocs/tasks_bloc.dart';
import 'package:modulife2/tasks/tasks.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (BuildContext _) => const TaskPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext _) => TasksBloc(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'TODOs',
          profile: null,
          isBackButtonEnabled: true,
        ),
        body: TaskView(),
      ),
    );
  }
}
