import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife_todos/modulife_todos.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext _) =>
            TodoBloc(todoRepository: TodoRepository())..add(LoadTodos()),
        child: const TodoPage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'TODO list',
        profile: null,
        isBackButtonEnabled: true,
      ),
      body: Stack(
        children: [
          Container(
            color: UiColors.background,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TodoList(),
          ),
        ],
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
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
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.accentColor1,
          title: const Text(
            'Add TODO',
            style: TextStyle(color: UiColors.background),
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter TODO title',
              fillColor: UiColors.background,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(color: UiColors.background)),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  final Todo newTodo = Todo(
                    title: controller.text,
                  );
                  context.read<TodoBloc>().add(AddTodo(todo: newTodo));
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: UiColors.accentColor2),
              child: const Text('Add',
                  style: TextStyle(color: UiColors.accentColor1)),
            ),
          ],
        );
      },
    );
  }
}
