import 'package:arkademi_test/commons/config/enviroments.dart';
import 'package:dio/dio.dart';

class CoursesDioClient {
  static final CoursesDioClient _instance = CoursesDioClient._();
  final Dio dio;

  factory CoursesDioClient() => _instance;

  CoursesDioClient._() : dio = Dio() {
    dio.options.baseUrl = Enviroments.baseUrl;
  }
}
