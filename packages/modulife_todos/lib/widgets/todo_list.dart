import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife_todos/blocs/todo/todo_bloc.dart';
import 'package:modulife_todos/blocs/folder/folder_bloc.dart';
import 'package:modulife_todos/models/models.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Map<String, bool> _isFolderExpanded = {};
  String searchQuery = "";

  final Center _empty = Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'No TODOs or Folders created! Add a new TODO by clicking on the "+" button on the bottom right.',
        style: TextStyle(color: Colors.grey[600], fontSize: 18),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        _buildTodoCounter(context),
        Expanded(
          child: BlocBuilder<FolderBloc, FolderState>(
            builder: (BuildContext context, FolderState folderState) {
              return BlocBuilder<TodoBloc, TodoState>(
                builder: (BuildContext context, TodoState todoState) {
                  if (todoState.status == TodoStatus.initial &&
                      folderState.status == FolderStatus.initial) {
                    return _empty;
                  }

                  if (todoState.status == TodoStatus.loading ||
                      folderState.status == FolderStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (todoState.status == TodoStatus.success &&
                      folderState.status == FolderStatus.success) {
                    if (todoState.allTodos.isEmpty &&
                        folderState.allFolders.isEmpty) {
                      return _empty;
                    }

                    List<Widget> todoWidgets =
                    _buildFolderAndTodos(context, todoState, folderState);

                    return ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: todoWidgets,
                    );
                  } else if (todoState.status == TodoStatus.failure ||
                      folderState.status == FolderStatus.failure) {
                    return const Center(
                      child: Text(
                        'Error loading TODOs and Folders.',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    );
                  }
                  return const Center(child: Text('Unknown state'));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFolderAndTodos(
      BuildContext context, TodoState todoState, FolderState folderState) {
    List<Widget> widgets = [];

    List<Todo> floatingTodos = todoState.allTodos
        .where((todo) => todo.folderId == null)
        .where((todo) => todo.title.toLowerCase().contains(searchQuery))
        .toList();

    if (floatingTodos.isNotEmpty) {
      widgets.addAll(floatingTodos.map((todo) => _buildTodoItem(context, todo)));
    }

    List<Folder> filteredFolders = folderState.allFolders
        .where((folder) =>
    folder.title.toLowerCase().contains(searchQuery) ||
        folder.todos.any((todo) =>
            todo.title.toLowerCase().contains(searchQuery)))
        .toList();

    for (Folder folder in filteredFolders) {
      final bool isExpanded = _isFolderExpanded[folder.id] ?? false;
      widgets.add(
        GestureDetector(
          onLongPress: () => _showFolderOptions(context, folder),
          child: ListTile(
            leading: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: UiColors.background,
            ),
            title: Text(folder.title),
            onTap: () {
              setState(() {
                _isFolderExpanded[folder.id] = !isExpanded;
              });
            },
          ),
        ),
      );
      if (isExpanded) {
        widgets.addAll(folder.todos
            .where((todo) =>
        todo.title.toLowerCase().contains(searchQuery) || searchQuery.isEmpty)
            .map((todo) => _buildTodoItem(context, todo))
            .toList());
      }
    }

    return widgets;
  }

  Widget _buildTodoItem(BuildContext context, Todo todo) {
    bool isExpanded = _isFolderExpanded[todo.id] ?? false;

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
                    _isFolderExpanded[todo.id] = !isExpanded;
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

  Widget _buildTodoCounter(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (BuildContext context, TodoState todoState) {
        return BlocBuilder<FolderBloc, FolderState>(
          builder: (BuildContext context, FolderState folderState) {
            final int totalTodos = todoState.allTodos.length +
                folderState.allFolders.fold<int>(
                    0, (sum, folder) => sum + folder.todos.length);
            final int completedTodos = todoState.allTodos
                .where((todo) => todo.isDone)
                .length +
                folderState.allFolders.fold<int>(
                    0,
                        (sum, folder) =>
                    sum + folder.todos.where((todo) => todo.isDone).length);

            return Text(
              'Total: $totalTodos, Completed: $completedTodos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: UiColors.accentColor1,
              ),
            );
          },
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
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        filled: true,
        fillColor: UiColors.accentColor1,
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

  void _showFolderOptions(BuildContext context, Folder folder) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext modalContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Folder'),
              onTap: () {
                // Implement Folder Edit logic here
                Navigator.pop(modalContext);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Folder'),
              onTap: () {
                context.read<FolderBloc>().add(DeleteFolder(folder: folder));
                Navigator.pop(modalContext);
              },
            ),
          ],
        );
      },
    );
  }
}
