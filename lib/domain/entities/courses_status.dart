import 'package:arkademi_test/domain/entities/curriculum.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'courses_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CoursesStatus extends Equatable {
  final String courseName;
  final String progress;
  final List<Curriculum> curriculum;

  const CoursesStatus({
    required this.courseName,
    required this.progress,
    required this.curriculum,
  });

  factory CoursesStatus.fromJson(Map<String, dynamic> json) =>
      _$CoursesStatusFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesStatusToJson(this);

  CoursesStatus copyWith({
    String? courseName,
    String? progress,
    List<Curriculum>? curriculum,
  }) {
    return CoursesStatus(
      courseName: courseName ?? this.courseName,
      progress: progress ?? this.progress,
      curriculum: curriculum ?? this.curriculum,
    );
  }

  @override
  List<Object?> get props => [courseName, progress, curriculum];
}
