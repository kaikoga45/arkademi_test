import 'package:arkademi_test/commons/enum/curriculum_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'curriculum.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Curriculum extends Equatable {
  final int key;
  final dynamic id;
  final CurriculumType type;
  final String title;
  final int duration;
  final String content;
  final List<dynamic> meta;
  final int? status;
  final String? onlineVideoLink;
  final String? offlineVideoLink;

  const Curriculum({
    required this.key,
    required this.id,
    required this.type,
    required this.title,
    required this.duration,
    required this.content,
    required this.meta,
    this.status,
    this.onlineVideoLink,
    this.offlineVideoLink,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) =>
      _$CurriculumFromJson(json);

  Map<String, dynamic> toJson() => _$CurriculumToJson(this);

  Curriculum copyWith({
    int? key,
    dynamic id,
    CurriculumType? type,
    String? title,
    int? duration,
    String? content,
    List<dynamic>? meta,
    int? status,
    String? onlineVideoLink,
    String? offlineVideoLink,
  }) {
    return Curriculum(
      key: key ?? this.key,
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      content: content ?? this.content,
      meta: meta ?? this.meta,
      status: status ?? this.status,
      onlineVideoLink: onlineVideoLink ?? this.onlineVideoLink,
      offlineVideoLink: offlineVideoLink ?? this.offlineVideoLink,
    );
  }

  @override
  List<Object?> get props => [
        key,
        id,
        type,
        title,
        duration,
        content,
        meta,
        status,
        onlineVideoLink,
        offlineVideoLink,
      ];
}
