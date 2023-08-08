import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_event.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_state.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/get_task.dart';

class RemoteTasksBloc extends Bloc<RemoteTasksEvent, RemoteTasksState> {
  final GetTasksUseCase _getTasksUseCase;

  RemoteTasksBloc(this._getTasksUseCase) : super(const RemoteTasksLoading()) {
    on<GetTasks>(onGetTasks);
  }

  void onGetTasks(GetTasks event, Emitter<RemoteTasksState> emit) async {
    final dataState = await _getTasksUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteTasksDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteTasksError(dataState.error!));
    }
  }
}
