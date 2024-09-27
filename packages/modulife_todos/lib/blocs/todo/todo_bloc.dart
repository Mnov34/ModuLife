import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:modulife_todos/repositories/todo_repository.dart';
import 'package:modulife_todos/models/todo.dart';

import 'package:modulife_utils/modulife_utils.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(const TodoState()) {
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodoStatus>(_onToggleTodoStatus);
    on<LoadTodos>(_onLoadTodos);

    LogService.i('TodoBloc initialized');
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    LogService.d('AddTodo event triggered: ${event.todo}');
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = List<Todo>.from(state.allTodos)
      ..add(event.todo);

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));

    await _saveTodos(updatedTodos);
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    LogService.d('UpdateTodo event triggered: ${event.todo}');
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos.map((Todo todo) {
      return todo.id == event.todo.id ? event.todo : todo;
    }).toList();

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));

    await _saveTodos(updatedTodos);
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    LogService.d('DeleteTodo event triggered: ${event.todos}');
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos
        .where((Todo todo) => !event.todos.any((Todo t) => t.id == todo.id))
        .toList();

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));

    await _saveTodos(updatedTodos);
  }

  Future<void> _onToggleTodoStatus(
      ToggleTodoStatus event, Emitter<TodoState> emit) async {
    LogService.d('ToggleTodo event triggered: ${event.todo}');
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos.map((Todo todo) {
      return todo.id == event.todo.id
          ? todo.copyWith(isDone: !todo.isDone)
          : todo;
    }).toList();

    emit(state.copyWith(allTodos: updatedTodos, status: TodoStatus.success));

    await _saveTodos(updatedTodos);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    LogService.d('LoadTodos event triggered.');
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      final List<Todo> loadedTodos = await todoRepository.loadTodos();
      emit(state.copyWith(allTodos: loadedTodos, status: TodoStatus.success));
      LogService.i('Todos loaded successfully. Total todos: ${loadedTodos}');
    } catch (e, stackTrace) {
      emit(state.copyWith(status: TodoStatus.failure));
      LogService.e('Failed to load todos', e, stackTrace);
    }
  }

  /// Helper method to save todos and log the result
  Future<void> _saveTodos(List<Todo> todos) async {
    try {
      await todoRepository.saveTodos(todos);
      LogService.i('Todos saved successfully. Total todos: ${todos.length}');
    } catch (e, stackTrace) {
      LogService.e('Failed to save todos', e, stackTrace);
    }
  }
}
