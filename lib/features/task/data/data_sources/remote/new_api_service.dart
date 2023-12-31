import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:to_do_mobi/core/constants/constants.dart';
import 'package:to_do_mobi/features/task/data/models/task.dart';
part 'new_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class NewApiService {
  factory NewApiService(Dio dio) = _NewApiService;

  @GET("/tasks")
  Future<HttpResponse<List<TaskModel>>> getTasks();

  @GET("/tasks/{id}")
  Future<HttpResponse<TaskModel>> getSingleTask(
    @Path("id") String taskId,
  );

  @POST("/tasks")
  Future<HttpResponse<TaskModel>> createTask(
    @Body() TaskModel taskModel,
  );

  @PATCH("/tasks/{id}")
  Future<HttpResponse<TaskModel>> updateTask(
    @Path("id") String taskId,
    @Body() TaskModel taskModel,
  );

  @DELETE("/tasks/{id}")
  Future<HttpResponse<void>> deleteTask(
    @Path("id") String taskId,
  );
}
