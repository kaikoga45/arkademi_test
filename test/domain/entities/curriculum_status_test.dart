import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/courses_data_test.dart';

void main() {
  group('Curriculum Status', () {
    test('props', () {
      const curriculumStatus1 = curriculumStatusDummyModelData;
      final curriculumStatus2 = curriculumStatusDummyModelData.copyWith();

      expect(curriculumStatus1, equals(curriculumStatus2));

      final curriculumStatus3 = curriculumStatusDummyModelData.copyWith(id: 2);
      expect(curriculumStatus1, isNot(equals(curriculumStatus3)));
    });
    test('copyWith', () {
      final curriculumStatusCopy = curriculumStatusDummyModelData.copyWith();
      expect(curriculumStatusCopy, isNot(same(curriculumStatusDummyModelData)));

      expect(
          curriculumStatusCopy.key, equals(curriculumStatusDummyModelData.key));
      expect(curriculumStatusCopy.isCompleted,
          equals(curriculumStatusDummyModelData.isCompleted));
      expect(curriculumStatusCopy.isCurrent,
          equals(curriculumStatusDummyModelData.isCurrent));
      expect(curriculumStatusCopy.isOffline,
          equals(curriculumStatusDummyModelData.isOffline));
      expect(curriculumStatusCopy.curriculum,
          equals(curriculumStatusDummyModelData.curriculum));
      expect(curriculumStatusCopy.offlineVideoPath,
          equals(curriculumStatusDummyModelData.offlineVideoPath));
    });
  });
}
