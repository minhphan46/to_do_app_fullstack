import 'package:to_do_mobi/core/usecases/usecase.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

import '../repository/task_repository.dart';

class SaveLocalTasksUseCase implements UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  SaveLocalTasksUseCase(this._taskRepository);

  @override
  Future<void> call({TaskEntity? params}) {
    return _taskRepository.saveTaskLocal(params!);
  }
}
