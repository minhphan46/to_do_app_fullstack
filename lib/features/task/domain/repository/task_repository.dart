import 'package:to_do_mobi/features/task/domain/entities/task.dart';

import '../../../../core/resources/data_state.dart';

abstract class TaskRepository {
  // API remote
  Future<DataState<List<TaskEntity>>> getTasks();
  Future<DataState<TaskEntity>> getTask(int id);
  Future<DataState<TaskEntity>> createTask(TaskEntity task);
  Future<DataState<TaskEntity>> updateTask(TaskEntity task);
  Future<DataState<TaskEntity>> deleteTask(int id);

  // database local
  Future<List<TaskEntity>> getTasksLocal();

  Future<void> saveTaskLocal(TaskEntity task);

  Future<void> removeTaskLocal(TaskEntity task);
}
