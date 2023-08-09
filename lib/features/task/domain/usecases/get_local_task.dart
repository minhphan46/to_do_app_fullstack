import 'package:to_do_mobi/core/usecases/usecase.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

import '../repository/task_repository.dart';

class GetLocalTasksUseCase implements UseCase<List<TaskEntity>, void> {
  final TaskRepository _taskRepository;

  GetLocalTasksUseCase(this._taskRepository);

  @override
  Future<List<TaskEntity>> call({void params}) {
    return _taskRepository.getTasksLocal();
  }
}
