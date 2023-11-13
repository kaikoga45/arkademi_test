import 'package:arkademi_test/domain/entities/curriculum.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/courses_data_test.dart';

void main() {
  group('Curriculum', () {
    const curriculum = curriculumDummyModelData;

    test('fromJson', () {
      const json = curriculumDummyJsonData;
      expect(Curriculum.fromJson(json), curriculum);
    });

    test('toJson', () {
      const json = curriculumDummyJsonData;
      expect(curriculum.toJson(), json);
    });

    test('copyWith', () {
      final curriculumCopy = curriculumDummyModelData.copyWith();
      expect(curriculumCopy, isNot(same(curriculumDummyModelData)));

      expect(curriculumCopy.key, equals(curriculumDummyModelData.key));
      expect(curriculumCopy.id, equals(curriculumDummyModelData.id));
      expect(curriculumCopy.type, equals(curriculumDummyModelData.type));
      expect(curriculumCopy.title, equals(curriculumDummyModelData.title));
      expect(
          curriculumCopy.duration, equals(curriculumDummyModelData.duration));
      expect(curriculumCopy.content, equals(curriculumDummyModelData.content));
      expect(curriculumCopy.meta, equals(curriculumDummyModelData.meta));
      expect(curriculumCopy.status, equals(curriculumDummyModelData.status));
      expect(curriculumCopy.onlineVideoLink,
          equals(curriculumDummyModelData.onlineVideoLink));
      expect(curriculumCopy.offlineVideoLink,
          equals(curriculumDummyModelData.offlineVideoLink));
    });
  });
}
