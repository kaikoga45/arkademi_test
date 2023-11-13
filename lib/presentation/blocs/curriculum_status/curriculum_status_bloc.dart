import 'package:arkademi_test/domain/entities/courses_status.dart';
import 'package:arkademi_test/domain/entities/curriculum_status.dart';
import 'package:arkademi_test/domain/repositories/courses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'curriculum_status_event.dart';
part 'curriculum_status_state.dart';

class CurriculumStatusBloc
    extends Bloc<CurriculumStatusEvent, CurriculumStatusState> {
  final CoursesRepository coursesRepository;

  CurriculumStatusBloc(this.coursesRepository)
      : super(CurriculumStatusInitial()) {
    on<CurriculumStatusFetch>(_curriculumStatusFetch);
    on<CurriculumStatusUpdateCurrentSelectCourse>(
        _curriculumStatusUpdateCurrentSelectCourse);
    on<CurriculumStatusUpdateCurrentOfflineVideoStatus>(
        _curriculumStatusUpdateCurrentOfflineVideoStatus);
    on<CurriculumStatusSetComplete>(_curriculumStatusSetComplete);
  }

  Future<void> _curriculumStatusFetch(
      CurriculumStatusFetch event, Emitter<CurriculumStatusState> emit) async {
    emit(CurriculumStatusLoading());
    try {
      final curriculumStatus =
          await coursesRepository.getCurriculumStatus(event.coursesStatus);
      emit(CurriculumStatusLoaded(curriculumStatus));
    } catch (e) {
      emit(CurriculumStatusError(e.toString()));
    }
  }

  Future<void> _curriculumStatusUpdateCurrentSelectCourse(
      CurriculumStatusUpdateCurrentSelectCourse event,
      Emitter<CurriculumStatusState> emit) async {
    final listCurriculumStatus =
        (state as CurriculumStatusLoaded).curriculumStatus;

    emit(CurriculumStatusLoading());

    final selectedCurriculumStatus =
        coursesRepository.updateCurrentSelectCurriculumStatus(
      listCurriculumStatus,
      event.selectedCurriculumStatus,
    );

    emit(CurriculumStatusLoaded(selectedCurriculumStatus));
  }

  Future<void> _curriculumStatusUpdateCurrentOfflineVideoStatus(
      CurriculumStatusUpdateCurrentOfflineVideoStatus event,
      Emitter<CurriculumStatusState> emit) async {
    final listCurriculumStatus =
        (state as CurriculumStatusLoaded).curriculumStatus;

    emit(CurriculumStatusLoading());

    final selectedCurriculumStatus =
        await coursesRepository.updateCurrentOfflineCurriculumVideoStatus(
      listCurriculumStatus,
      event.curriculumStatus,
    );

    emit(CurriculumStatusLoaded(selectedCurriculumStatus));
  }

  Future<void> _curriculumStatusSetComplete(CurriculumStatusSetComplete event,
      Emitter<CurriculumStatusState> emit) async {
    final listCurriculumStatus =
        (state as CurriculumStatusLoaded).curriculumStatus;

    emit(CurriculumStatusLoading());

    final selectedCurriculumStatus =
        coursesRepository.setCompleteCurriculumStatus(
      listCurriculumStatus,
      event.isLastCourse,
    );

    emit(CurriculumStatusLoaded(selectedCurriculumStatus));
  }
}
