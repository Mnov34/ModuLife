part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

final class TodoState extends Equatable {
  final List<Todo> allTodos;
  final TodoStatus status;

  const TodoState({
    this.allTodos = const <Todo>[],
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    List<Todo>? allTodos,
    TodoStatus? status,
  }) {
    return TodoState(
      allTodos: allTodos ?? List.from(this.allTodos),
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [allTodos, status];
}
