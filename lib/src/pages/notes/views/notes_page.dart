import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife/src/widgets/custom_scaffold.dart';

import 'package:modulife_ui_colors/modulife_ui_colors.dart';
import 'package:modulife/src/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:modulife_notes/modulife_notes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (BuildContext context) {
      return BlocProvider(
          create: (BuildContext _) =>
              NoteBloc(noteRepository: NoteRepository())..add(LoadNotes()));
    });
  }

  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Notes',
      body: Stack(
        children: [
          Container(
            color: UiColors.background,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            //child: NotesList(),
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
                  Icon(Icons.create_new_folder, color: UiColors.secondaryColor),
              title: Text('Create Folder'),
            ),
          ),
          const PopupMenuItem(
            value: 'Note',
            child: ListTile(
              leading: Icon(Icons.note_add, color: UiColors.secondaryColor),
              title: Text('Create Note'),
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
        );
      },
    );
  }
}
