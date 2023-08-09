import 'package:equatable/equatable.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

abstract class LocalTaskEvent extends Equatable {
  final TaskEntity? task;

  const LocalTaskEvent({this.task});

  @override
  List<Object?> get props => [task!];
}

class SaveLocalTask extends LocalTaskEvent {
  const SaveLocalTask(TaskEntity task) : super(task: task);
}

class RemoveLocalTask extends LocalTaskEvent {
  const RemoveLocalTask(TaskEntity task) : super(task: task);
}

class GetLocalTasks extends LocalTaskEvent {
  const GetLocalTasks();
}
