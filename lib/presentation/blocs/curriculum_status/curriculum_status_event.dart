part of 'curriculum_status_bloc.dart';

class CurriculumStatusEvent {}

class CurriculumStatusFetch extends CurriculumStatusEvent {
  final CoursesStatus coursesStatus;

  CurriculumStatusFetch(this.coursesStatus);
}

class CurriculumStatusUpdateCurrentSelectCourse extends CurriculumStatusEvent {
  final CurriculumStatus selectedCurriculumStatus;

  CurriculumStatusUpdateCurrentSelectCourse(this.selectedCurriculumStatus);
}

class CurriculumStatusUpdateCurrentOfflineVideoStatus
    extends CurriculumStatusEvent {
  final CurriculumStatus curriculumStatus;

  CurriculumStatusUpdateCurrentOfflineVideoStatus(this.curriculumStatus);
}

class CurriculumStatusSetComplete extends CurriculumStatusEvent {
  final bool isLastCourse;

  CurriculumStatusSetComplete(this.isLastCourse);
}
