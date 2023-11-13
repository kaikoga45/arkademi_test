import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:arkademi_test/commons/config/enviroments.dart';

void main() {
  setUpAll(() {
    dotenv.load(fileName: '.env');
  });
  test('Enviroments should fetch BASE_URL from environment variables', () {
    // Arrange
    final expectedBaseUrl = dotenv.get('BASE_URL');

    // Act
    final actualBaseUrl = Enviroments.baseUrl;

    // Assert
    expect(actualBaseUrl, expectedBaseUrl);
  });
}
