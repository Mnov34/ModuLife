import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:modulife_todos/models/todo.dart';

class TodoRepository {
  static const String todosKey = 'todos_key';

  Future<void> saveTodos(List<Todo> todos) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String todosJson =
        jsonEncode(todos.map((Todo todo) => todo.toMap()).toList());

    await prefs.setString(todosKey, todosJson);
  }

  Future<List<Todo>> loadTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString(todosKey);

    if (todosJson != null) {
      final List<dynamic> jsonList = jsonDecode(todosJson);
      return jsonList.map((dynamic json) => Todo.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> clearTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(todosKey);
  }
}
