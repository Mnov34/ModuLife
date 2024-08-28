part of 'tasks_bloc.dart';

enum TasksStatus { initial, loading, success, failure }

final class TasksState extends Equatable {
  final List<Task> allTasks;
  final TasksStatus status;

  const TasksState({
    this.allTasks = const <Task>[],
    this.status = TasksStatus.initial,
  });

  TasksState copyWith({
    List<Task>? allTasks,
    TasksStatus? status,
}) {
    return TasksState(
      allTasks: allTasks ?? this.allTasks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [allTasks, status];
}