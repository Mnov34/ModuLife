import 'dart:convert';

import 'package:modulife_todos/models/folder.dart';

import 'package:modulife_utils/modulife_utils.dart';

class FolderRepository {
  static const String folderKey = 'todos_folder_key';

  /// Save the list of folders to storage
  Future<void> saveFolders(List<Folder> folder) async {
    try {
      final String folderJson =
          jsonEncode(folder.map((Folder folder) => folder.toMap()).toList());

      await StorageUtils().saveString(folderKey, folderJson);
    } catch (e) {
      LogService.e('Failed to save Folders', e);
    }
  }

  /// Load the list of folders from storage
  Future<List<Folder>> loadFolders() async {
    try {
      final String? folderJson = StorageUtils().getString(folderKey);

      if (folderJson != null) {
        final List<dynamic> jsonList = jsonDecode(folderJson);
        return jsonList.map((dynamic json) => Folder.fromMap(json)).toList();
      } else {
        LogService.i('No folders found in storage');
        return [];
      }
    } catch (e) {
      LogService.e('Failed to load folders', e);
      return [];
    }
  }

  /// Clear all folders from storage
  Future<void> clearFolders() async {
    try {
      await StorageUtils().remove(folderKey);
    } catch (e) {
      LogService.e('Failed to clear folders', e);
    }
  }
}
