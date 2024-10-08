part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class DeleteTodo extends TodoEvent {
  final List<Todo> todos;

  const DeleteTodo({required List<Todo> todos}) : todos = todos;

  @override
  List<Object> get props => [todos];
}

final class ToggleTodoStatus extends TodoEvent {
  final Todo todo;

  const ToggleTodoStatus({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class LoadTodos extends TodoEvent {
  @override
  List<Object> get props => [];
}
