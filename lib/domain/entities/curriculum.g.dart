// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Curriculum _$CurriculumFromJson(Map<String, dynamic> json) => Curriculum(
      key: json['key'] as int,
      id: json['id'],
      type: $enumDecode(_$CurriculumTypeEnumMap, json['type']),
      title: json['title'] as String,
      duration: json['duration'] as int,
      content: json['content'] as String,
      meta: json['meta'] as List<dynamic>,
      status: json['status'] as int?,
      onlineVideoLink: json['online_video_link'] as String?,
      offlineVideoLink: json['offline_video_link'] as String?,
    );

Map<String, dynamic> _$CurriculumToJson(Curriculum instance) =>
    <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'type': _$CurriculumTypeEnumMap[instance.type]!,
      'title': instance.title,
      'duration': instance.duration,
      'content': instance.content,
      'meta': instance.meta,
      'status': instance.status,
      'online_video_link': instance.onlineVideoLink,
      'offline_video_link': instance.offlineVideoLink,
    };

const _$CurriculumTypeEnumMap = {
  CurriculumType.section: 'section',
  CurriculumType.unit: 'unit',
};
