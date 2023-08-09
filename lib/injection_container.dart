import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_mobi/features/task/data/data_sources/remote/new_api_service.dart';
import 'package:to_do_mobi/features/task/domain/repository/task_repository.dart';
import 'package:to_do_mobi/features/task/domain/usecases/remote/get_tasks.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';

import 'features/task/data/data_sources/local/app_database.dart';
import 'features/task/data/repository/task_repository_impl.dart';
import 'features/task/domain/usecases/local/get_local_task.dart';
import 'features/task/domain/usecases/local/remove_task.dart';
import 'features/task/domain/usecases/local/save_local_task.dart';
import 'features/task/presentation/bloc/task/local/local_task_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final localDatabase =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(localDatabase);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies Injection
  sl.registerSingleton<NewApiService>(NewApiService(sl<Dio>()));

  sl.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(
      sl<NewApiService>(),
      sl<AppDatabase>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetTasksUseCase>(
    GetTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  // use cases local
  sl.registerSingleton<GetLocalTasksUseCase>(
    GetLocalTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<SaveLocalTasksUseCase>(
    SaveLocalTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<RemoveLocalTasksUseCase>(
    RemoveLocalTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  // blocs
  sl.registerFactory<RemoteTasksBloc>(
      () => RemoteTasksBloc(sl<GetTasksUseCase>()));

  sl.registerFactory<LocalTasksBloc>(() => LocalTasksBloc(
        sl<GetLocalTasksUseCase>(),
        sl<SaveLocalTasksUseCase>(),
        sl<RemoveLocalTasksUseCase>(),
      ));
}
