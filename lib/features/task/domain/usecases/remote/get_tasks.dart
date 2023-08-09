import 'package:to_do_mobi/core/resources/data_state.dart';
import 'package:to_do_mobi/core/usecases/usecase.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

import '../../repository/task_repository.dart';

class GetTasksUseCase implements UseCase<DataState<List<TaskEntity>>, void> {
  final TaskRepository _taskRepository;

  GetTasksUseCase(this._taskRepository);

  @override
  Future<DataState<List<TaskEntity>>> call({void params}) {
    return _taskRepository.getTasks();
  }
}
