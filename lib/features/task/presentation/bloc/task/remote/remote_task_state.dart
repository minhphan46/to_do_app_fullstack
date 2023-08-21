import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

abstract class RemoteTasksState extends Equatable {
  final List<TaskEntity>? tasks;
  final DioException? error;

  const RemoteTasksState({this.tasks, this.error});

  @override
  List<Object?> get props => [tasks, error];
}

class RemoteTasksInitial extends RemoteTasksState {
  const RemoteTasksInitial();
}

class RemoteTasksLoading extends RemoteTasksState {
  const RemoteTasksLoading();
}

class RemoteTasksDone extends RemoteTasksState {
  const RemoteTasksDone(List<TaskEntity> tasks) : super(tasks: tasks);
}

class RemoteTasksError extends RemoteTasksState {
  const RemoteTasksError(DioException error) : super(error: error);
}
