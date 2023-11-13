part of 'courses_status_bloc.dart';

class CoursesStatusState {}

final class CoursesStatusInitial extends CoursesStatusState {}

final class CoursesStatusLoading extends CoursesStatusState {}

final class CoursesStatusLoaded extends CoursesStatusState {
  final CoursesStatus coursesStatus;

  CoursesStatusLoaded(this.coursesStatus);
}

final class CoursesStatusError extends CoursesStatusState {
  final String message;

  CoursesStatusError(this.message);
}
