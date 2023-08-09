import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/domain/usecases/get_local_task.dart';
import 'package:to_do_mobi/features/task/domain/usecases/remove_task.dart';
import 'package:to_do_mobi/features/task/domain/usecases/save_local_task.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/local/local_task_event.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/local/local_task_state.dart';

class LocalTasksBloc extends Bloc<LocalTaskEvent, LocalTaskState> {
  final GetLocalTasksUseCase _getLocalTasksUseCase;
  final SaveLocalTasksUseCase _saveLocalTasksUseCase;
  final RemoveLocalTasksUseCase _removeLocalTaskUseCase;

  LocalTasksBloc(
    this._getLocalTasksUseCase,
    this._saveLocalTasksUseCase,
    this._removeLocalTaskUseCase,
  ) : super(const LocalTaskLoading()) {
    on<GetLocalTasks>(onGetLocalTasks);
    on<SaveLocalTask>(onSaveLocalTasks);
    on<RemoveLocalTask>(onRemoveLocalTasks);
  }

  void onGetLocalTasks(
      GetLocalTasks event, Emitter<LocalTaskState> emit) async {
    final tasks = await _getLocalTasksUseCase();
    emit(LocalTaskDone(tasks));
  }

  void onSaveLocalTasks(
      SaveLocalTask event, Emitter<LocalTaskState> emit) async {
    await _saveLocalTasksUseCase(params: event.task);
    final tasks = await _getLocalTasksUseCase();
    emit(LocalTaskDone(tasks));
  }

  void onRemoveLocalTasks(
      RemoveLocalTask event, Emitter<LocalTaskState> emit) async {
    await _removeLocalTaskUseCase(params: event.task);
    final tasks = await _getLocalTasksUseCase();
    emit(LocalTaskDone(tasks));
  }
}
