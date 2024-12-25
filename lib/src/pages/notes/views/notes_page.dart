import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modulife/src/widgets/custom_scaffold/custom_scaffold.dart';

import 'package:modulife_ui_colors/modulife_ui_colors.dart';
import 'package:modulife_notes/modulife_notes.dart';

@RoutePage()
class NotesPage extends StatefulWidget implements AutoRouteWrapper {
  const NotesPage({super.key});

  static final NoteRepository noteRepository = NoteRepository();
  static final FolderRepository folderRepository = FolderRepository();

  @override
  State<StatefulWidget> createState() => _NotesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
            create: (BuildContext context) =>
                NoteBloc(noteRepository: NotesPage.noteRepository)
                  ..add(LoadNotes())),
        BlocProvider<FolderBloc>(
            create: (BuildContext context) =>
                FolderBloc(folderRepository: NotesPage.folderRepository)
                  ..add(LoadFolders())),
      ],
      child: this,
    );
  }
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Notes',
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        //child: NotesList(),
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
