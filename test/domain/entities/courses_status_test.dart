import 'package:flutter_test/flutter_test.dart';
import 'package:arkademi_test/domain/entities/courses_status.dart';

void main() {
  test('CoursesStatus can be serialized and deserialized', () {
    const coursesStatus = CoursesStatus(
      courseName: 'Test Course',
      progress: '50%',
      curriculum: [], // Replace with actual curriculum data
    );

    final json = coursesStatus.toJson();

    expect(json, {
      'course_name': 'Test Course',
      'progress': '50%',
      'curriculum': [], // Replace with expected JSON for curriculum
    });

    final deserializedCoursesStatus = CoursesStatus.fromJson(json);

    expect(deserializedCoursesStatus, coursesStatus);
  });

  test('CoursesStatus can be copied with updated values', () {
    const coursesStatus = CoursesStatus(
      courseName: 'Test Course',
      progress: '50%',
      curriculum: [], // Replace with actual curriculum data
    );

    final copiedCoursesStatus = coursesStatus.copyWith(
      courseName: null,
    );

    expect(copiedCoursesStatus.courseName, 'Test Course');
    expect(copiedCoursesStatus.progress, '50%');
    expect(copiedCoursesStatus.curriculum, coursesStatus.curriculum);
  });
}
