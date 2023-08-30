import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/domain/usecases/remote/save_task.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_event.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_state.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/remote/get_tasks.dart';
import '../../../../domain/usecases/remote/remove_task.dart';
import '../../../../domain/usecases/remote/update_task.dart';

class RemoteTasksBloc extends Bloc<RemoteTasksEvent, RemoteTasksState> {
  final GetTasksUseCase _getTasksUseCase;
  final SaveTaskUseCase _saveTaskUseCase;
  final RemoveTaskUseCase _removeTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  RemoteTasksBloc(
    this._getTasksUseCase,
    this._saveTaskUseCase,
    this._removeTaskUseCase,
    this._updateTaskUseCase,
  ) : super(const RemoteTasksLoading()) {
    on<GetTasks>(onGetTasks);
    on<CreateTask>(onCreateTask);
    on<UpdateTask>(onUpdateTask);
    on<DeleteTask>(onRemoveTask);
  }

  void onGetTasks(GetTasks event, Emitter<RemoteTasksState> emit) async {
    emit(const RemoteTasksLoading());

    final dataState = await _getTasksUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteTasksDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteTasksError(dataState.error!));
    }
  }

  void onCreateTask(CreateTask event, Emitter<RemoteTasksState> emit) async {
    emit(const RemoteCreatingTask());
    await _saveTaskUseCase(params: event.task);
    final dataState = await _getTasksUseCase();
    if (dataState is DataSuccess) {
      emit(const RemoteCreatedTask());
    }

    if (dataState is DataFailed) {
      emit(RemoteTasksError(dataState.error!));
    }
  }

  void onUpdateTask(UpdateTask event, Emitter<RemoteTasksState> emit) async {
    emit(const RemoteUpdatingTask());
    final dataState = await _updateTaskUseCase(params: event.task);

    if (dataState is DataSuccess) {
      emit(const RemoteUpdatedTask());
    }

    if (dataState is DataFailed) {
      emit(RemoteTasksError(dataState.error!));
    }
  }

  void onRemoveTask(DeleteTask event, Emitter<RemoteTasksState> emit) async {
    emit(const RemoteRemovingTask());
    final dataState = await _removeTaskUseCase(params: event.id);

    if (dataState is DataSuccess) {
      emit(const RemoteRemovedTask());
    }

    if (dataState is DataFailed) {
      emit(RemoteTasksError(dataState.error!));
    }
  }
}
