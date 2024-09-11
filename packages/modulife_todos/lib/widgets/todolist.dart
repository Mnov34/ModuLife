import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife_todos/blocs/todo_bloc.dart';
import 'package:modulife_todos/models/models.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Map<String, bool> _isExpended = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (BuildContext context, TodoState state) {
        if (state.status == TodoStatus.initial) {
          return Center(
            child: Text(
              'No TODOs created! Add a new TODO by clicking on the "+" button on the bottom right.',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          );
        }

        if (state.status == TodoStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == TodoStatus.success) {
          if (state.allTodos.isEmpty) {
            return Center(
              child: Text(
                'No TODOs created! Add a new TODO by clicking on the "+" button on the bottom right.',
                style: TextStyle(color: Colors.grey[600], fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.allTodos.length,
            itemBuilder: (BuildContext context, int index) {
              final Todo todo = state.allTodos[index];
              bool isExpended = _isExpended[todo.id] ?? false;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: todo.isDone
                      ? UiColors.accentColor1.withOpacity(0.6)
                      : UiColors.accentColor1,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: todo.isDone ? Colors.grey : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _isExpended[todo.id] = !isExpended;
                              });
                            },
                            icon: Icon(
                              isExpended
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: UiColors.background,
                            )),
                      ],
                    ),
                    if (isExpended) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              _showEditTodoDialog(context, todo);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: UiColors.accentColor2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodo(todo: todo));
                            },
                            icon: const Icon(Icons.delete,
                                color: UiColors.dangerRed),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        } else if (state.status == TodoStatus.failure) {
          return Center(
            child: Text(
              'Error loading TODOs.',
              style: TextStyle(color: UiColors.dangerRed, fontSize: 18),
            ),
          );
        }
        return const Center(child: Text('Unknown state'));
      },
    );
  }

  void _showEditTodoDialog(BuildContext context, Todo todo) {
    final TextEditingController controller = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.accentColor1,
          title: const Text(
            'Edit TODO',
            style: TextStyle(color: UiColors.background),
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter new TODO title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: UiColors.background)),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  final Todo updatedTodo = todo.copyWith(title: controller.text);
                  context.read<TodoBloc>().add(UpdateTodo(todo: updatedTodo));  // Dispatch event to update TODO
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: UiColors.accentColor2),
              child: const Text('Update', style: TextStyle(color: UiColors.accentColor1)),
            ),
          ],
        );
      },
    );
  }
}
