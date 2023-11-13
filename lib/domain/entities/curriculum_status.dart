import 'package:arkademi_test/domain/entities/curriculum.dart';
import 'package:equatable/equatable.dart';

class CurriculumStatus extends Equatable {
  final int key;
  final bool isCompleted;
  final bool isCurrent;
  final bool isOffline;
  final Curriculum curriculum;
  final String? offlineVideoPath;

  const CurriculumStatus({
    required this.key,
    required this.curriculum,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isOffline = false,
    this.offlineVideoPath,
  });

  CurriculumStatus copyWith({
    int? id,
    bool? isCompleted,
    bool? isCurrent,
    bool? isOffline,
    Curriculum? curriculum,
    String? offlineVideoPath,
  }) {
    return CurriculumStatus(
      key: id ?? key,
      isCompleted: isCompleted ?? this.isCompleted,
      isCurrent: isCurrent ?? this.isCurrent,
      isOffline: isOffline ?? this.isOffline,
      curriculum: curriculum ?? this.curriculum,
      offlineVideoPath: offlineVideoPath ?? this.offlineVideoPath,
    );
  }

  @override
  List<Object?> get props => [
        key,
        isCompleted,
        isCurrent,
        isOffline,
        curriculum,
        offlineVideoPath,
      ];
}
