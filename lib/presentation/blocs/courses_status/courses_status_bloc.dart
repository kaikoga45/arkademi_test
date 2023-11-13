import 'package:arkademi_test/domain/entities/courses_status.dart';
import 'package:arkademi_test/domain/entities/entities.dart';
import 'package:arkademi_test/domain/repositories/courses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_status_event.dart';
part 'courses_status_state.dart';

class CoursesStatusBloc extends Bloc<CoursesStatusEvent, CoursesStatusState> {
  final CoursesRepository repository;

  CoursesStatusBloc(this.repository) : super(CoursesStatusInitial()) {
    on<CoursesStatusFetch>(_coursesStatusFetch);
  }

  Future<void> _coursesStatusFetch(
      CoursesStatusFetch event, Emitter<CoursesStatusState> emit) async {
    emit(CoursesStatusLoading());
    try {
      final coursesStatus = await repository.getCoursesStatus();
      emit(CoursesStatusLoaded(coursesStatus));
    } catch (e) {
      emit(CoursesStatusError(e.toString()));
    }
  }
}
