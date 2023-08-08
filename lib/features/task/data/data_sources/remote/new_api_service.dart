import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:to_do_mobi/core/constants/constants.dart';
import 'package:to_do_mobi/features/task/data/models/task.dart';
part 'new_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class NewApiService {
  factory NewApiService(Dio dio) = _NewApiService;

  @GET("/tasks")
  Future<HttpResponse<List<TaskModel>>> getTasks({
    @Query("page") int page = 1,
  });
}
