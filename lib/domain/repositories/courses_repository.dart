import 'package:arkademi_test/commons/enum/curriculum_type.dart';
import 'package:arkademi_test/commons/extension/int_extension.dart';
import 'package:arkademi_test/data/api/courses_api.dart';
import 'package:arkademi_test/data/local/file_local.dart';
import 'package:arkademi_test/domain/entities/courses_status.dart';
import 'package:arkademi_test/domain/entities/curriculum_status.dart';
import 'package:arkademi_test/domain/entities/entities.dart';

class CoursesRepository {
  final CoursesApi _coursesApi;
  final FileLocal _fileLocal;

  CoursesRepository(
    this._coursesApi,
    this._fileLocal,
  );

  Future<CoursesStatus> getCoursesStatus() async {
    final result = await _coursesApi.getCoursesStatus();
    final readableCurriculumTitleFromHtmlEntity = result.copyWith(
      curriculum: result.curriculum
          .map((e) => e.copyWith(
                title: e.title.replaceAll('&#8211;', '-'),
              ))
          .toList(),
    );
    return readableCurriculumTitleFromHtmlEntity;
  }

  Future<List<CurriculumStatus>> getCurriculumStatus(
      CoursesStatus coursesStatus) async {
    final curriculumStatus = coursesStatus.curriculum
        .asMap()
        .map(
          (index, e) => MapEntry(
            index,
            CurriculumStatus(
              key: e.key,
              curriculum: e,
              isCurrent: index.isEqual(1),
            ),
          ),
        )
        .values
        .toList();

    final futures = curriculumStatus.map((e) async {
      if (e.curriculum.type == CurriculumType.section) {
        return e;
      }
      final isFileExist =
          await _fileLocal.isFileExist('${e.curriculum.title}.mp4');
      if (isFileExist) {
        final offlineVideoPath =
            await _fileLocal.getFilePath('${e.curriculum.title}.mp4');

        return e.copyWith(
          isOffline: isFileExist,
          offlineVideoPath: offlineVideoPath,
        );
      }
      return e;
    });

    final curriculumStatusWithOfflineStatus = await Future.wait(futures);
    return curriculumStatusWithOfflineStatus;
  }

  List<CurriculumStatus> updateCurrentSelectCurriculumStatus(
    List<CurriculumStatus> listCurriculumStatus,
    CurriculumStatus selectedCurriculumStatus,
  ) {
    final updatedCurriculumStatus = listCurriculumStatus.map((e) {
      if (e.key == selectedCurriculumStatus.key) {
        return e.copyWith(
          isCurrent: true,
        );
      }
      return e.copyWith(
        isCurrent: false,
      );
    }).toList();

    return updatedCurriculumStatus;
  }

  Future<List<CurriculumStatus>> updateCurrentOfflineCurriculumVideoStatus(
    List<CurriculumStatus> listCurriculumStatus,
    CurriculumStatus selectedCurriculumStatus,
  ) async {
    final offlineVideoPath = selectedCurriculumStatus.isOffline
        ? await _fileLocal
            .getFilePath('${selectedCurriculumStatus.curriculum.title}.mp4')
        : null;

    final updatedCurriculumStatus = listCurriculumStatus.map((e) {
      if (e.curriculum.key == selectedCurriculumStatus.key) {
        return e.copyWith(
          isOffline: selectedCurriculumStatus.isOffline,
          offlineVideoPath: offlineVideoPath,
        );
      }
      return e;
    }).toList();

    return updatedCurriculumStatus;
  }

  List<CurriculumStatus> setCompleteCurriculumStatus(
    List<CurriculumStatus> listCurriculumStatus,
    bool isLastCourse,
  ) {
    final updatedCurriculumStatusComplete = listCurriculumStatus.map((e) {
      if (e.isCurrent) {
        return e.copyWith(
          isCompleted: true,
          isCurrent: isLastCourse ? true : false,
        );
      }
      return e;
    }).toList();

    if (isLastCourse) {
      return updatedCurriculumStatusComplete;
    }

    final candidatNextCurriculum = updatedCurriculumStatusComplete
        .where((e) => e.curriculum.type == CurriculumType.unit)
        .firstWhere((e) => e.isCompleted != true)
        .curriculum;

    final newestListCurriculumStatus = updatedCurriculumStatusComplete.map((e) {
      if (e.curriculum.key == candidatNextCurriculum.key) {
        return e.copyWith(
          isCurrent: true,
        );
      }
      return e;
    }).toList();

    return newestListCurriculumStatus;
  }
}
