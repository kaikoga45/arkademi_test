import 'package:arkademi_test/data/api/courses_api.dart';
import 'package:arkademi_test/data/dio_client/course_dio_client.dart';
import 'package:arkademi_test/data/local/file_local.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerLazySingleton(() => CoursesApi(locator<CoursesDioClient>().dio))
    ..registerLazySingleton(() => CoursesDioClient())
    ..registerLazySingleton(() => FileLocal());
}
