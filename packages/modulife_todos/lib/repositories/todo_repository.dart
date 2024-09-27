import 'dart:convert';

import 'package:modulife_todos/models/todo.dart';

import 'package:modulife_utils/modulife_utils.dart';

class TodoRepository {
  static const String todosKey = 'todos_key';

  /// Save the list of todos to storage
  Future<void> saveTodos(List<Todo> todos) async {
    try {
      final String todosJson =
          jsonEncode(todos.map((Todo todo) => todo.toMap()).toList());

      await StorageUtils().saveString(todosKey, todosJson);
    } catch (e) {
      LogService.e('Failed to save todos', e);
    }
  }

  /// Load the list of todos from storage
  Future<List<Todo>> loadTodos() async {
    try {
      final String? todosJson = StorageUtils().getString(todosKey);

      if (todosJson != null) {
        final List<dynamic> jsonList = jsonDecode(todosJson);
        return jsonList.map((dynamic json) => Todo.fromMap(json)).toList();
      } else {
        LogService.i('No todos found in storage');
        return [];
      }
    } catch (e) {
      LogService.e('Failed to load todos', e);
      return [];
    }
  }

  /// Clear all todos from storage
  Future<void> clearTodos() async {
    try {
      await StorageUtils().remove(todosKey);
    } catch (e) {
      LogService.e('Failed to clear todos', e);
    }
  }
}
