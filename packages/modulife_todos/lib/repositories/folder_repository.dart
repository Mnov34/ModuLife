import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:modulife_todos/models/folder.dart';

class FolderRepository {
  static const String folderKey = 'folder_key';

  Future<void> saveFolders(List<Folder> folder) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String folderJson =
        jsonEncode(folder.map((Folder folder) => folder.toMap()).toList());

    await prefs.setString(folderKey, folderJson);
  }

  Future<List<Folder>> loadFolders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? folderJson = prefs.getString(folderKey);

    if (folderJson != null) {
      final List<dynamic> jsonList = jsonDecode(folderJson);
      return jsonList.map((dynamic json) => Folder.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> clearFolders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(folderKey);
  }
}
