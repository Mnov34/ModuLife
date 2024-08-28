import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:modulife2/tasks/models/models.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final List<Task> updatedTasks = List<Task>.from(state.allTasks)..add(event.task);
    emit(state.copyWith(allTasks: updatedTasks, status: TasksStatus.success));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final updatedTasks = state.allTasks.map((task) {
      return task.id == event.task.id ? event.task : task;
    }).toList();
    emit(state.copyWith(allTasks: updatedTasks, status: TasksStatus.success));
  }
  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final updatedTasks = state.allTasks.where((task) => task.id != event.task.id).toList();
    emit(state.copyWith(allTasks: updatedTasks, status: TasksStatus.success));
  }
}
