import 'package:to_do_mobi/core/usecases/usecase.dart';
import '../../../../../core/resources/data_state.dart';
import '../../repository/task_repository.dart';

class RemoveTaskUseCase implements UseCase<DataState<void>, String> {
  final TaskRepository _taskRepository;

  RemoveTaskUseCase(this._taskRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _taskRepository.deleteTask(params!);
  }
}
