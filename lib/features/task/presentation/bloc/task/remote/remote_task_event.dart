import '../../../../domain/entities/task.dart';

abstract class RemoteTasksEvent {
  const RemoteTasksEvent();
}

class GetTasks extends RemoteTasksEvent {
  const GetTasks();
}

// create task
class CreateTask extends RemoteTasksEvent {
  final TaskEntity task;

  const CreateTask(this.task);
}

// delete task
class DeleteTask extends RemoteTasksEvent {
  final String id;

  const DeleteTask(this.id);
}

// update task
class UpdateTask extends RemoteTasksEvent {
  final TaskEntity task;

  const UpdateTask(this.task);
}