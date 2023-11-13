part of 'curriculum_status_bloc.dart';

class CurriculumStatusState {}

final class CurriculumStatusInitial extends CurriculumStatusState {}

final class CurriculumStatusLoading extends CurriculumStatusState {}

final class CurriculumStatusLoaded extends CurriculumStatusState {
  final List<CurriculumStatus> curriculumStatus;

  CurriculumStatusLoaded(this.curriculumStatus);
}

final class CurriculumStatusError extends CurriculumStatusState {
  final String message;

  CurriculumStatusError(this.message);
}
