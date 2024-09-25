import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife/widgets/custom_app_bar.dart';

import 'package:modulife_todos/modulife_todos.dart';
import 'package:modulife_todos/repositories/folder_repository.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

@RoutePage()
class TodoPage extends StatefulWidget implements AutoRouteWrapper {
  const TodoPage({super.key});

  static final TodoRepository todoRepository = TodoRepository();
  static final FolderRepository folderRepository = FolderRepository();

  @override
  State<TodoPage> createState() => _TodoPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
            create: (BuildContext context) =>
                TodoBloc(todoRepository: TodoPage.todoRepository)
                  ..add(LoadTodos())),
        BlocProvider<FolderBloc>(
            create: (BuildContext context) =>
                FolderBloc(folderRepository: TodoPage.folderRepository)
                  ..add(LoadFolders())),
      ],
      child: this,
    );
  }
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'TODO list',
        profile: null,
        isBackButtonEnabled: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: TodoList(),
      ),
      floatingActionButton: PopupMenuButton<String>(
        offset: const Offset(0, -122),
        onSelected: (String value) {
          _showAddDialog(context, value);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 'Folder',
            child: ListTile(
              leading: Icon(Icons.create_new_folder,
                  color: UiColors.secondaryColor),
              title: Text('Create Folder'),
            ),
          ),
          const PopupMenuItem(
            value: 'TODO',
            child: ListTile(
              leading: Icon(Icons.note_add, color: UiColors.secondaryColor),
              title: Text('Create TODO'),
            ),
          ),
        ],
        icon: const CircleAvatar(
          radius: 33,
          backgroundColor: UiColors.primaryColor,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: UiColors.secondaryColor,
            child: Icon(
              Icons.add,
              color: UiColors.primaryColor,
              size: 27,
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext parentContext, String type) {
    final TextEditingController controller = TextEditingController();
    Folder? selectedFolder;

    showDialog(
      context: parentContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.primaryColor,
          title: Text(
            'Add $type',
            style: const TextStyle(color: UiColors.background),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter $type title',
                      fillColor: UiColors.background,
                    ),
                  ),
                  if (type == 'TODO')
                    BlocBuilder<FolderBloc, FolderState>(
                      bloc: BlocProvider.of<FolderBloc>(parentContext),
                      builder: (BuildContext context, FolderState state) {
                        return DropdownButton<Folder?>(
                          value: selectedFolder,
                          hint: const Text('Select Folder (optional)'),
                          isExpanded: true,
                          onChanged: (Folder? folder) {
                            setState(() {
                              selectedFolder = folder;
                            });
                          },
                          items: [
                            const DropdownMenuItem<Folder?>(
                              value: null,
                              child: Text('No Folder'),
                            ),
                            ...state.allFolders.map((Folder folder) {
                              return DropdownMenuItem<Folder?>(
                                value: folder,
                                child: Text(folder.title),
                              );
                            }),
                          ],
                        );
                      },
                    ),
                ],
              );
            },
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
                  if (type == 'TODO') {
                    final Todo newTodo = Todo(
                      title: controller.text,
                      folderId: selectedFolder?.id,
                    );

                    if (selectedFolder != null && selectedFolder?.id != null) {
                      final List<Todo> updatedFolderTodos =
                          List<Todo>.from(selectedFolder!.todos)..add(newTodo);

                      final Folder updatedFolder = Folder(
                        id: selectedFolder?.id,
                        title: selectedFolder!.title,
                        todos: updatedFolderTodos,
                      );

                      parentContext
                          .read<FolderBloc>()
                          .add(UpdateFolder(folder: updatedFolder));
                    }

                    parentContext.read<TodoBloc>().add(AddTodo(todo: newTodo));
                  } else if (type == 'Folder') {
                    final Folder newFolder = Folder(title: controller.text);
                    parentContext
                        .read<FolderBloc>()
                        .add(AddFolder(folder: newFolder));
                  }
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: UiColors.secondaryColor),
              child: const Text('Add',
                  style: TextStyle(color: UiColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }
}
