import 'package:to_do_mobi/core/usecases/usecase.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';
import '../../../../../core/resources/data_state.dart';
import '../../repository/task_repository.dart';

class UpdateTaskUseCase implements UseCase<DataState<void>, TaskEntity>{
  final TaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  @override
  Future<DataState<void>> call({TaskEntity? params}) {
    return _taskRepository.updateTask(params!);
  }
}
