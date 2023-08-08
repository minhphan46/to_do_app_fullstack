import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_mobi/features/task/data/data_sources/remote/new_api_service.dart';
import 'package:to_do_mobi/features/task/domain/repository/task_repository.dart';
import 'package:to_do_mobi/features/task/domain/usecases/get_task.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';

import 'features/task/data/repository/task_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies Injection
  sl.registerSingleton<NewApiService>(NewApiService(sl<Dio>()));

  sl.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(
      sl<NewApiService>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetTasksUseCase>(
    GetTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  // blocs
  sl.registerFactory<RemoteTasksBloc>(
      () => RemoteTasksBloc(sl<GetTasksUseCase>()));
}
