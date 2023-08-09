import 'package:equatable/equatable.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

abstract class LocalTaskState extends Equatable {
  final List<TaskEntity>? tasks;

  const LocalTaskState({this.tasks});

  @override
  List<Object?> get props => [tasks!];
}

class LocalTaskInitial extends LocalTaskState {
  const LocalTaskInitial();
}

class LocalTaskLoading extends LocalTaskState {
  const LocalTaskLoading();
}

class LocalTaskDone extends LocalTaskState {
  const LocalTaskDone(List<TaskEntity> tasks) : super(tasks: tasks);
}