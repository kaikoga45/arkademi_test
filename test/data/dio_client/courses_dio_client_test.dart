import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arkademi_test/commons/config/enviroments.dart';
import 'package:arkademi_test/data/dio_client/course_dio_client.dart';

void main() {
  setUpAll(() {
    dotenv.load(fileName: '.env');
  });
  test('CoursesDioClient should set Dio baseUrl to Enviroments.baseUrl', () {
    // Arrange
    final expectedBaseUrl = Enviroments.baseUrl;

    // Act
    final coursesDioClient = CoursesDioClient();
    final actualBaseUrl = coursesDioClient.dio.options.baseUrl;

    // Assert
    expect(actualBaseUrl, expectedBaseUrl);
  });
}
