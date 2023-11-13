import 'package:arkademi_test/domain/repositories/courses_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/courses_data_test.dart';
import '../../mocks/api_test.mocks.dart';
import '../../mocks/local_test.mocks.dart';

void main() {
  group('CoursesRepository', () {
    final mockCoursesApi = MockCoursesApi();
    final mockFileLocal = MockFileLocal();
    final coursesRepository = CoursesRepository(mockCoursesApi, mockFileLocal);

    test('getCoursesStatus', () async {
      when(mockCoursesApi.getCoursesStatus())
          .thenAnswer((_) async => coursesStatusDummyModelData);
      final result = await coursesRepository.getCoursesStatus();
      expect(result, equals(coursesStatusDummyModelData));
    });
  });
}
