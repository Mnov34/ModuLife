import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:modulife_todos/models/models.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = List<Todo>.from(state.allTodos)
      ..add(event.todo);

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos = state.allTodos.map((todo) {
      return todo.id == event.todo.id ? event.todo : todo;
    }).toList();

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));

    final List<Todo> updatedTodos =
        state.allTodos.where((todo) => todo.id != event.todo.id).toList();

    emit(state.copyWith(
      allTodos: updatedTodos,
      status: TodoStatus.success,
    ));
  }
}
