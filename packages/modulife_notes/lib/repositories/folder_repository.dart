import 'dart:convert';

import 'package:modulife_notes/models/folder.dart';
import 'package:modulife_utils/modulife_utils.dart';

class FolderRepository {
  static const String folderKey = 'notes_folder_key';

  final StorageUtils _prefs = StorageUtils();

  /// Save the list of notes folder to storage
  Future<void> saveFolders(List<Folder> folder) async {
    final String folderJson =
    jsonEncode(folder.map((Folder folder) => folder.toMap()).toList());

    await _prefs.saveString(folderKey, folderJson);
  }

  /// Load the list of notes folders from storage
  Future<List<Folder>> loadFolders() async {
    final String? folderJson = _prefs.getString(folderKey);

    if (folderJson != null) {
      final List<dynamic> jsonList = jsonDecode(folderJson);
      return jsonList.map((dynamic json) => Folder.fromMap(json)).toList();
    } else {
      LogService.i('No folders found in storage');
      return [];
    }
  }

  /// Remove all notes from storage
  Future<void> clearFolders() async {
    await _prefs.remove(folderKey);
  }
}
