/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife_todos/blocs/folder/folder_bloc.dart';
import 'package:modulife_todos/models/models.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

class FolderTreeView extends StatefulWidget {
  const FolderTreeView({super.key});

  @override
  _FolderTreeViewState createState() => _FolderTreeViewState();
}

class _FolderTreeViewState extends State<FolderTreeView> {
  Map<String, bool> folderExpansionState = {};
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        _buildFolderCounter(context),
        Expanded(
          child: BlocBuilder<FolderBloc, FolderState>(
            builder: (BuildContext context, FolderState state) {
              if (state.status == FolderStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == FolderStatus.success) {
                if (state.allFolders.isEmpty) {
                  return Center(
                      child: Text(
                    'No folders created.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 18),
                  ));
                }

                List<Folder> filteredFolders = state.allFolders
                    .where((Folder folder) =>
                        folder.title.toLowerCase().contains(searchQuery))
                    .toList();

                List<Todo> floatingTodos = state.all

                return ListView.builder(
                  itemCount: filteredFolders.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Folder folder = filteredFolders[index];
                    final bool isExpanded =
                        folderExpansionState[folder.id] ?? false;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress: () =>
                              _showFolderOptions(context, folder),
                          child: ListTile(
                            leading: Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              color: Colors.black,
                            ),
                            title: Text(folder.title),
                            subtitle: Text(folder.description),
                            onTap: () {
                              setState(() {
                                folderExpansionState[folder.id] = !isExpanded;
                              });
                            },
                          ),
                        ),
                        if (isExpanded) ..._buildFolderContent(context, folder),
                      ],
                    );
                  },
                );
              } else if (state.status == FolderStatus.failure) {
                return const Center(child: Text('Failed to load folders.'));
              } else {
                return const Center(child: Text('Unknown state.'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFolderCounter(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (BuildContext context, FolderState state) {
        final int totalFolders = state.allFolders.length;
        final int totalTodos = state.allFolders
            .fold(0, (sum, folder) => sum + folder.todos.length);
        final int completedTodos = state.allFolders.fold(
            0,
            (sum, folder) =>
                sum + folder.todos.where((Todo todo) => todo.isDone).length);

        return Text(
          'Folders: $totalFolders, Total TODOs: $totalTodos, Completed: $completedTodos',
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
      decoration: const InputDecoration(
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

  List<Widget> _buildFolderContent(BuildContext context, Folder folder) {
    return folder.todos.map((Todo todo) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 32.0), // Indent to mimic tree branch
        child: ListTile(
          leading: const Icon(Icons.circle, size: 10, color: Colors.grey),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: todo.isDone ? Colors.grey : Colors.black,
            ),
          ),
          trailing: Checkbox(
            value: todo.isDone,
            onChanged: (bool? value) {
              context.read<FolderBloc>().add(UpdateFolder(folder: folder));
            },
          ),
        ),
      );
    }).toList();
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
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(modalContext);
                _showEditFolderDialog(context, folder);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
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

  void _showEditFolderDialog(BuildContext context, Folder folder) {
    final TextEditingController titleController =
        TextEditingController(text: folder.title);
    final TextEditingController descriptionController =
        TextEditingController(text: folder.description);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Edit Folder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Folder Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(hintText: 'Folder Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final String title = titleController.text.trim();
                final String description = descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final Folder updatedFolder =
                      folder.copyWith(title: title, description: description);
                  context
                      .read<FolderBloc>()
                      .add(UpdateFolder(folder: updatedFolder));
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
*/
