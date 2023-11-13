import 'package:arkademi_test/data/api/courses_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/courses_data_test.dart';
import '../mocks/dependency_test.mocks.dart';

void main() {
  late CoursesApi api;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    api = CoursesApi(dio);
  });

  test('getCoursesStatus returns expected data', () async {
    when(dio.get(any)).thenAnswer(
      (_) async => Response(
        data: coursesStatusDummyJsonData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await api.getCoursesStatus();

    expect(result, coursesStatusDummyModelData);
  });

  test('getCoursesStatus throws DioError', () async {
    when(dio.get(any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      error: 'error',
      type: DioExceptionType.unknown,
    ));

    expect(() => api.getCoursesStatus(), throwsA(isA<DioException>()));
  });
}
