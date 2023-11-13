import 'package:arkademi_test/domain/entities/entities.dart';
import 'package:dio/dio.dart';

class CoursesApi {
  final _coursesStatusPath = 'course-status.json';

  final Dio _dio;

  CoursesApi(this._dio);

  Future<CoursesStatus> getCoursesStatus() async {
    final response = await _dio.get(_coursesStatusPath);
    return CoursesStatus.fromJson(response.data);
  }
}
