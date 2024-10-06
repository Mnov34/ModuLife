import 'dart:convert';

import 'package:modulife_todos/models/todo.dart';

import 'package:modulife_utils/modulife_utils.dart';

class TodoRepository {
  static const String todosKey = 'todos_key';

  final StorageUtils _prefs = StorageUtils();

  /// Save the list of todos to storage
  Future<void> saveTodos(List<Todo> todos) async {
    final String todosJson =
        jsonEncode(todos.map((Todo todo) => todo.toMap()).toList());

    await _prefs.saveString(todosKey, todosJson);
  }

  /// Load the list of todos from storage
  Future<List<Todo>> loadTodos() async {
    final String? todosJson = _prefs.getString(todosKey);

    if (todosJson != null) {
      final List<dynamic> jsonList = jsonDecode(todosJson);
      return jsonList.map((dynamic json) => Todo.fromMap(json)).toList();
    } else {
      LogService.i('No todos found in storage');
      return [];
    }
  }

  /// Clear all todos from storage
  Future<void> clearTodos() async {
    await _prefs.remove(todosKey);
  }
}
