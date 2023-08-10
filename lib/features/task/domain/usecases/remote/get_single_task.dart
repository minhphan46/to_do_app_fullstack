import 'package:to_do_mobi/core/resources/data_state.dart';
import 'package:to_do_mobi/core/usecases/usecase.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

import '../../repository/task_repository.dart';

class GetSingleTaskUseCase implements UseCase<DataState<TaskEntity>, String> {
  final TaskRepository _taskRepository;

  GetSingleTaskUseCase(this._taskRepository);

  @override
  Future<DataState<TaskEntity>> call({String? params}) {
    return _taskRepository.getTask(params!);
  }
}
