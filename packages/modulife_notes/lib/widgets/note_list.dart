import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modulife_notes/modulife_notes.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  Map<String, bool> _isFolderExpanded = {};
  String searchQuery = "";

  final Center _empty = Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'No notes or folders created!\n\nGet started by clicking the "+" button on the bottom right.',
        style: TextStyle(color: Colors.grey[600], fontSize: 22),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _buildSearchBar(),
        // _buildNoteCounter(context),
        Expanded(
          child: BlocBuilder<FolderBloc, FolderState>(
            builder: (BuildContext context, FolderState folderState) {
              return BlocBuilder<NoteBloc, NoteState>(
                builder: (BuildContext context, NoteState noteState) {
                  if (noteState.status == NoteStatus.initial &&
                      folderState.status == FolderStatus.initial) {
                    return _empty;
                  }

                  if (noteState.status == NoteStatus.loading ||
                      folderState.status == FolderStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (noteState.status == NoteStatus.success &&
                      folderState.status == FolderStatus.success) {
                    if (noteState.allNotes.isEmpty &&
                        folderState.allFolders.isEmpty) {
                      return _empty;
                    }

                    List<Widget> noteWidgets =
                        _buildFoldersAndNotes(context, noteState, folderState);

                    return ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: noteWidgets,
                    );
                  } else if (noteState.status == NoteStatus.failure ||
                      folderState.status == FolderStatus.failure) {
                    return const Center(
                      child: Text(
                        'Error loading Notes and Folders.',
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

  List<Widget> _buildFoldersAndNotes(
      BuildContext context, NoteState noteState, FolderState folderState) {
    List<Widget> widgets = [];

    List<Note> floatingNotes = noteState.allNotes
        .where((Note note) => note.folderId == null)
        .where((Note note) => note.title.toLowerCase().contains(searchQuery))
        .toList();

    if (floatingNotes.isNotEmpty) {
      /*widgets.addAll(
          floatingNotes.map((Note note) => _buildNoteItem(context, note)));*/
    }

    List<Folder> filteredFolders = folderState.allFolders
        .where((Folder folder) =>
            folder.title.toLowerCase().contains(searchQuery) ||
            folder.notes.any(
                (Note note) => note.title.toLowerCase().contains(searchQuery)))
        .toList();

    for (Folder folder in filteredFolders) {
      //widgets.add(_buildFolderItem(context, folder, noteState.allNotes));
    }

    return widgets;
  }
}
