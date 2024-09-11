import 'package:flutter/cupertino.dart';
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
  Map<String, bool> _isExpanded = {};
  String searchQuery = "";

  final Center _empty = Center(
    child: Text(
      'No TODOs created! Add a new TODO by clicking on the "+" button on the bottom right.',
      style: TextStyle(color: Colors.grey[600], fontSize: 18),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        _buildTodoCounter(context),
        Expanded(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (BuildContext context, TodoState state) {
              if (state.status == TodoStatus.initial) {
                return _empty;
              }

              if (state.status == TodoStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == TodoStatus.success) {
                if (state.allTodos.isEmpty) {
                  return _empty;
                }

                List<Widget> todoWidgets = _separateTodos(state, context);

                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: todoWidgets,
                );
              } else if (state.status == TodoStatus.failure) {
                return Center(
                  child: Text(
                    'Error loading TODOs.',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }
              return const Center(child: Text('Unknown state'));
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _separateTodos(TodoState state, BuildContext context) {
    final List<Todo> filteredTodos = state.allTodos
        .where((todo) => todo.title.toLowerCase().contains(searchQuery))
        .toList();

    final List<Todo> incompleteTodos =
        filteredTodos.where((todo) => !todo.isDone).toList();
    final List<Todo> completedTodos =
        filteredTodos.where((todo) => todo.isDone).toList();

    final List<Widget> todoWidgets = [];

    todoWidgets.addAll(
      incompleteTodos.map((todo) => _buildTodoItem(context, todo)),
    );

    if (completedTodos.isNotEmpty && incompleteTodos.isNotEmpty) {
      todoWidgets.add(_buildSeparator());
    }

    todoWidgets.addAll(
      completedTodos.map((todo) => _buildTodoItem(context, todo)),
    );

    return todoWidgets;
  }

  Widget _buildTodoItem(BuildContext context, Todo todo) {
    bool isExpanded = _isExpanded[todo.id] ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: UiColors.background,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded[todo.id] = !isExpanded;
                  });
                },
              ),
              Checkbox(
                value: todo.isDone,
                activeColor: UiColors.accentColor2,
                onChanged: (bool? value) {
                  context.read<TodoBloc>().add(ToggleTodoStatus(todo: todo));
                },
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _showEditTodoDialog(context, todo);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Edit',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.edit, color: UiColors.accentColor2),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(DeleteTodo(todo: todo));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.delete, color: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context, Todo todo) {
    final TextEditingController controller =
        TextEditingController(text: todo.title);

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
              child: const Text('Cancel',
                  style: TextStyle(color: UiColors.background)),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  final Todo updatedTodo =
                      todo.copyWith(title: controller.text);
                  context.read<TodoBloc>().add(UpdateTodo(todo: updatedTodo));
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: UiColors.accentColor2),
              child: const Text('Update',
                  style: TextStyle(color: UiColors.accentColor1)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 2,
              height: 30,
              color: Colors.grey,
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildTodoCounter(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (BuildContext context, TodoState state) {
        final int totalTodos = state.allTodos.length;
        final int completedTodos =
            state.allTodos.where((Todo todo) => todo.isDone).length;
        final int incompleteTodos = totalTodos - completedTodos;

        return Text(
          'Total: $totalTodos, Incomplete: $incompleteTodos, Completed: $completedTodos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: UiColors.accentColor1,
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (String value) {
        setState(() {
          searchQuery = value.toLowerCase();
        });
      },
      decoration: InputDecoration(
        hintText: 'Search TODOs...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        filled: true,
        fillColor: UiColors.accentColor1,
      ),
    );
  }
}
