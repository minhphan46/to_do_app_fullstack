import 'package:to_do_mobi/features/task/domain/entities/task.dart';

import '../../../../core/resources/data_state.dart';

abstract class TaskRepository {
  // API remote
  Future<DataState<List<TaskEntity>>> getTasks();
  Future<DataState<TaskEntity>> getTask(String id);
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String id);

  // database local
  Future<List<TaskEntity>> getTasksLocal();

  Future<void> saveTaskLocal(TaskEntity task);

  Future<void> removeTaskLocal(TaskEntity task);
}
