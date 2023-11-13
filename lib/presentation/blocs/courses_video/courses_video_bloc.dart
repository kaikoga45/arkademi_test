import 'package:arkademi_test/domain/repositories/file_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_video_event.dart';
part 'courses_video_state.dart';

class CoursesVideoBloc extends Bloc<CoursesVideoEvent, CoursesVideoState> {
  final FileRepository fileRepository;

  CoursesVideoBloc(this.fileRepository) : super(CoursesVideoInitial()) {
    on<CoursesVideoDownload>(_coursesVideoDownload);
    on<CoursesVideoDelete>(_coursesVideoDelete);
  }

  Future<void> _coursesVideoDownload(
      CoursesVideoDownload event, Emitter<CoursesVideoState> emit) async {
    try {
      await for (final progress
          in fileRepository.saveFileFromUrl(event.url, event.fileName)) {
        if (progress == 100) {
          break;
        }
        emit(CoursesVideoDownloadProgress(progress));
      }
      emit(CoursesVideoDownloaded());
    } catch (e) {
      emit(CoursesVideoFailed(e.toString()));
    }
  }

  Future<void> _coursesVideoDelete(
      CoursesVideoDelete event, Emitter<CoursesVideoState> emit) async {
    try {
      await fileRepository.deleteFile(event.fileName);
      emit(CoursesVideoDeleted());
    } catch (e) {
      emit(CoursesVideoFailed(e.toString()));
    }
  }
}
