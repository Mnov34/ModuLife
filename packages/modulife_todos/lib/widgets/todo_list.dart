import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife_todos/modulife_todos.dart';
import 'package:modulife_todos/repositories/folder_repository.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Map<String, bool> _isFolderExpanded = {};
  Map<String, bool> _isTodoExpanded = {};
  String searchQuery = "";

  final Center _empty = Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'No TODOs or Folders created!\n\nGet started by clicking the "+" button on the bottom right.',
        style: TextStyle(color: Colors.grey[600], fontSize: 22),
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

                      List<Widget> todoWidgets = _buildFoldersAndTodos(
                          context, todoState, folderState);

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

  List<Widget> _buildFoldersAndTodos(
      BuildContext context, TodoState todoState, FolderState folderState) {
    List<Widget> widgets = [];

    List<Todo> floatingTodos = todoState.allTodos
        .where((Todo todo) => todo.folderId == null)
        .where((Todo todo) => todo.title.toLowerCase().contains(searchQuery))
        .toList();

    if (floatingTodos.isNotEmpty) {
      widgets.addAll(
          floatingTodos.map((Todo todo) => _buildTodoItem(context, todo)));
    }

    List<Folder> filteredFolders = folderState.allFolders
        .where((Folder folder) =>
            folder.title.toLowerCase().contains(searchQuery) ||
            folder.todos.any(
                (Todo todo) => todo.title.toLowerCase().contains(searchQuery)))
        .toList();

    for (Folder folder in filteredFolders) {
      widgets.add(_buildFolderItem(context, folder, todoState.allTodos));
    }

    return widgets;
  }

  Widget _buildFolderItem(
      BuildContext context, Folder folder, List<Todo> allTodos) {
    final bool isExpanded = _isFolderExpanded[folder.id] ?? false;

    List<Todo> folderTodos =
        allTodos.where((Todo todo) => todo.folderId == folder.id).toList();
    bool allTodosCompleted =
        folderTodos.isNotEmpty && folderTodos.every((todo) => todo.isDone);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: allTodosCompleted
            ? UiColors.secondaryColor
            : UiColors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          GestureDetector(
            onLongPress: () {
              _showFolderOptions(context, folder);
            },
            onTap: () {
              setState(() {
                _isFolderExpanded[folder.id] = !isExpanded;
              });
            },
            child: Row(
              children: [
                Icon(Icons.snippet_folder),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 2,
                    height: 15,
                    color: UiColors.background,
                  ),
                ),
                Expanded(
                  child: Text(
                    folder.title,
                    style: TextStyle(
                      decoration:
                          allTodosCompleted ? TextDecoration.lineThrough : null,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: UiColors.background,
                ),
              ],
            ),
          ),
          if (isExpanded) _buildTodosForFolder(context, folder, allTodos)
        ],
      ),
    );
  }

  Widget _buildTodosForFolder(
      BuildContext context, Folder folder, List<Todo> allTodos) {
    List<Todo> folderTodos = allTodos
        .where((Todo todo) => todo.folderId == folder.id)
        .where((Todo todo) => todo.title.toLowerCase().contains(searchQuery))
        .toList();

    if (folderTodos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No TODOs in this folder.'),
      );
    }

    return Column(
      children: [
        Divider(
          color: UiColors.background,
          thickness: 2,
        ),
        Column(
          children: folderTodos
              .map((Todo todo) => _buildTodoItem(context, todo))
              .toList(),
        ),
      ],
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
                Navigator.pop(modalContext);
                _showEditFolderDialog(context, folder);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: UiColors.dangerRed,
              ),
              title: const Text('Delete Folder'),
              onTap: () {
                Navigator.pop(modalContext);
                _showDeleteFolderConfirmation(context, folder);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditFolderDialog(BuildContext context, Folder folder) {
    final TextEditingController controller =
        TextEditingController(text: folder.title);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.primaryColor,
          title: const Text(
            'Edit Folder',
            style: TextStyle(color: UiColors.background),
          ),
          content: TextField(
            controller: controller,
            decoration:
                const InputDecoration(hintText: 'Enter new Folder title'),
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
                  final Folder updatedFolder =
                      folder.copyWith(title: controller.text);
                  context
                      .read<FolderBloc>()
                      .add(UpdateFolder(folder: updatedFolder));
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: UiColors.secondaryColor),
              child: const Text('Update',
                  style: TextStyle(color: UiColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteFolderConfirmation(BuildContext context, Folder folder) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.primaryColor,
          title: const Text('Delete Folder'),
          content: Text(
              'Are you sure you want to delete the "${folder.title}" folder?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                final List<Todo> todosToDelete = List<Todo>.from(folder.todos);

                context.read<FolderBloc>().add(DeleteFolder(folder: folder));
                context.read<TodoBloc>().add(DeleteTodo(todos: todosToDelete));
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(UiColors.dangerRed)),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoItem(BuildContext context, Todo todo) {
    bool isExpanded = _isTodoExpanded[todo.id] ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: todo.isDone ? UiColors.secondaryColor : UiColors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              todo.isDone
                  ? Icon(Icons.task_alt)
                  : Icon(Icons.radio_button_unchecked),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 2,
                  height: 15,
                  color: UiColors.background,
                ),
              ),
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
                    _isTodoExpanded[todo.id] = !isExpanded;
                  });
                },
              ),
              Checkbox(
                value: todo.isDone,
                activeColor: UiColors.accentColor,
                onChanged: (bool? value) {
                  context.read<TodoBloc>().add(ToggleTodoStatus(todo: todo));
                },
              ),
            ],
          ),
          if (isExpanded) ...[
            Divider(
              color: UiColors.background,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _showEditTodoDialog(context, todo);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.edit,
                          color: todo.isDone
                              ? UiColors.primaryColor
                              : UiColors.secondaryColor),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showDeleteTodoConfirmation(context, todo);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.delete,
                          color: todo.isDone
                              ? UiColors.dangerRed2
                              : UiColors.dangerRed),
                    ],
                  ),
                ),
              ],
            ),
          ],
          if (!isExpanded)
            Divider(
              color: UiColors.background,
              thickness: 2,
            ),
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
          backgroundColor: UiColors.primaryColor,
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
                  backgroundColor: UiColors.secondaryColor),
              child: const Text('Update',
                  style: TextStyle(color: UiColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTodoConfirmation(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.primaryColor,
          title: const Text('Delete Folder'),
          content:
              Text('Are you sure you want to delete the "${todo.title}" TODO?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(todos: [todo]));
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(UiColors.dangerRed)),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoCounter(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (BuildContext context, TodoState todoState) {
        return BlocBuilder<FolderBloc, FolderState>(
          builder: (BuildContext context, FolderState folderState) {
            final int totalTodos = todoState.allTodos.length +
                folderState.allFolders
                    .fold<int>(0, (sum, folder) => sum + folder.todos.length);
            final int completedTodos = todoState.allTodos
                    .where((todo) => todo.isDone)
                    .length +
                folderState.allFolders.fold<int>(
                    0,
                    (int sum, Folder folder) =>
                        sum + folder.todos.where((todo) => todo.isDone).length);

            return Text(
              'Total: $totalTodos, Completed: $completedTodos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: UiColors.primaryColor,
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
        fillColor: UiColors.primaryColor,
      ),
    );
  }
}
