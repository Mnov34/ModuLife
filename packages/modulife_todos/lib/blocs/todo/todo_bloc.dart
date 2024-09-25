import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:modulife_todos/repositories/todo_repository.dart';
import 'package:modulife_todos/models/todo.dart';

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
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = List<Todo>.from(state.allTodos)
      ..add(event.todo);

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));

    await todoRepository.saveTodos(updatedTodos);
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos.map((Todo todo) {
      return todo.id == event.todo.id ? event.todo : todo;
    }).toList();

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));

    await todoRepository.saveTodos(updatedTodos);
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos
        .where((Todo todo) => !event.todos.any((Todo t) => t.id == todo.id))
        .toList();

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));

    await todoRepository.saveTodos(updatedTodos);
  }

  Future<void> _onToggleTodoStatus(
      ToggleTodoStatus event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos.map((Todo todo) {
      return todo.id == event.todo.id
          ? todo.copyWith(isDone: !todo.isDone)
          : todo;
    }).toList();

    emit(state.copyWith(allTodos: updatedTodos, status: TodoStatus.success));

    await todoRepository.saveTodos(updatedTodos);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      final List<Todo> loadedTodos = await todoRepository.loadTodos();
      emit(state.copyWith(allTodos: loadedTodos, status: TodoStatus.success));
    } catch (_) {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }
}
