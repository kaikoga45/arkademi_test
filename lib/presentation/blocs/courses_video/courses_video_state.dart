part of 'courses_video_bloc.dart';

sealed class CoursesVideoState {}

final class CoursesVideoInitial extends CoursesVideoState {}

final class CoursesVideoDownloadProgress extends CoursesVideoState {
  final int progress;

  CoursesVideoDownloadProgress(this.progress);
}

final class CoursesVideoDownloaded extends CoursesVideoState {
  CoursesVideoDownloaded();
}

final class CoursesVideoDeleted extends CoursesVideoState {}

final class CoursesVideoFailed extends CoursesVideoState {
  final String message;

  CoursesVideoFailed(this.message);
}
