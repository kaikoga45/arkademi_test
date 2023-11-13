// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesStatus _$CoursesStatusFromJson(Map<String, dynamic> json) =>
    CoursesStatus(
      courseName: json['course_name'] as String,
      progress: json['progress'] as String,
      curriculum: (json['curriculum'] as List<dynamic>)
          .map((e) => Curriculum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursesStatusToJson(CoursesStatus instance) =>
    <String, dynamic>{
      'course_name': instance.courseName,
      'progress': instance.progress,
      'curriculum': instance.curriculum,
    };
