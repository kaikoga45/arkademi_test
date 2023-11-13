part of 'courses_video_bloc.dart';

sealed class CoursesVideoEvent {}

final class CoursesVideoDownload extends CoursesVideoEvent {
  final String url;
  final String fileName;

  CoursesVideoDownload(
    this.url,
    this.fileName,
  );
}

final class CoursesVideoDelete extends CoursesVideoEvent {
  final String fileName;

  CoursesVideoDelete(this.fileName);
}
