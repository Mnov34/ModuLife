import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife_todos/modulife_todos.dart';
import 'package:modulife_todos/repositories/folder_repository.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';
import 'package:modulife2/widgets/custom_app_bar.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext _) =>
                  FolderBloc(folderRepository: FolderRepository())
                    ..add(LoadFolders())),
          BlocProvider(
            create: (BuildContext _) =>
                TodoBloc(todoRepository: TodoRepository())..add(LoadTodos()),
          )
        ],
        child: const TodoPage(),
      );
    });
  }

  @override
  State<TodoPage> createState() => _TodoPageState();
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
      floatingActionButton: PopupMenuButton<String>(
        offset: const Offset(0, -122),
        onSelected: (String value) {
          _showAddDialog(context, value);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 'Folder',
            child: ListTile(
              leading:
                  Icon(Icons.create_new_folder, color: UiColors.accentColor2),
              title: Text('Create Folder'),
            ),
          ),
          const PopupMenuItem(
            value: 'TODO',
            child: ListTile(
              leading: Icon(Icons.note_add, color: UiColors.accentColor2),
              title: Text('Create TODO'),
            ),
          ),
        ],
        icon: const CircleAvatar(
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

  void _showAddDialog(BuildContext parentContext, String type) {
    final TextEditingController controller = TextEditingController();
    Folder? selectedFolder;

    showDialog(
      context: parentContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: UiColors.accentColor1,
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
