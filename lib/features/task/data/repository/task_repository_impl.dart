import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_mobi/core/resources/data_state.dart';
import 'package:to_do_mobi/features/task/data/data_sources/local/app_database.dart';
import 'package:to_do_mobi/features/task/data/data_sources/remote/new_api_service.dart';
import 'package:to_do_mobi/features/task/data/models/task.dart';
import 'package:to_do_mobi/features/task/data/models/task_local.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';
import 'package:to_do_mobi/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final NewApiService _newApiService;
  final AppDatabase _appDatabase;
  TaskRepositoryImpl(this._newApiService, this._appDatabase);

  @override
  Future<DataState<List<TaskModel>>> getTasks() async {
    try {
      final httpResponse = await _newApiService.getTasks(
        page: 1,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        print("error ${httpResponse.response.statusMessage}");
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      print("err: $e");
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> createTask(TaskEntity task) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<DataState<TaskModel>> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<DataState<TaskModel>> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<DataState<TaskModel>> updateTask(TaskEntity task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  //  local
  @override
  Future<List<TaskModel>> getTasksLocal() async {
    return _appDatabase.taskDao
        .getTasks()
        .then((value) => value.map((e) => TaskModel.fromLocal(e)).toList());
  }

  @override
  Future<void> removeTaskLocal(TaskEntity task) {
    return _appDatabase.taskDao
        .deleteTask(TaskLocalModel.fromLocal(TaskModel.fromEntity(task)));
  }

  @override
  Future<void> saveTaskLocal(TaskEntity task) {
    return _appDatabase.taskDao
        .insertTask(TaskLocalModel.fromLocal(TaskModel.fromEntity(task)));
  }
}
