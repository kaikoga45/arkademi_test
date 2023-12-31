// Mocks generated by Mockito 5.4.2 from annotations
// in arkademi_test/test/mocks/repositories_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:arkademi_test/data/local/file_local.dart' as _i3;
import 'package:arkademi_test/domain/entities/courses_status.dart' as _i2;
import 'package:arkademi_test/domain/entities/curriculum_status.dart' as _i6;
import 'package:arkademi_test/domain/repositories/courses_repository.dart'
    as _i4;
import 'package:arkademi_test/domain/repositories/file_repository.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCoursesStatus_0 extends _i1.SmartFake implements _i2.CoursesStatus {
  _FakeCoursesStatus_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFileLocal_1 extends _i1.SmartFake implements _i3.FileLocal {
  _FakeFileLocal_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CoursesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoursesRepository extends _i1.Mock implements _i4.CoursesRepository {
  MockCoursesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.CoursesStatus> getCoursesStatus() => (super.noSuchMethod(
        Invocation.method(
          #getCoursesStatus,
          [],
        ),
        returnValue: _i5.Future<_i2.CoursesStatus>.value(_FakeCoursesStatus_0(
          this,
          Invocation.method(
            #getCoursesStatus,
            [],
          ),
        )),
      ) as _i5.Future<_i2.CoursesStatus>);

  @override
  _i5.Future<List<_i6.CurriculumStatus>> getCurriculumStatus(
          _i2.CoursesStatus? coursesStatus) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurriculumStatus,
          [coursesStatus],
        ),
        returnValue: _i5.Future<List<_i6.CurriculumStatus>>.value(
            <_i6.CurriculumStatus>[]),
      ) as _i5.Future<List<_i6.CurriculumStatus>>);

  @override
  List<_i6.CurriculumStatus> updateCurrentSelectCurriculumStatus(
    List<_i6.CurriculumStatus>? listCurriculumStatus,
    _i6.CurriculumStatus? selectedCurriculumStatus,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateCurrentSelectCurriculumStatus,
          [
            listCurriculumStatus,
            selectedCurriculumStatus,
          ],
        ),
        returnValue: <_i6.CurriculumStatus>[],
      ) as List<_i6.CurriculumStatus>);

  @override
  _i5.Future<List<_i6.CurriculumStatus>>
      updateCurrentOfflineCurriculumVideoStatus(
    List<_i6.CurriculumStatus>? listCurriculumStatus,
    _i6.CurriculumStatus? selectedCurriculumStatus,
  ) =>
          (super.noSuchMethod(
            Invocation.method(
              #updateCurrentOfflineCurriculumVideoStatus,
              [
                listCurriculumStatus,
                selectedCurriculumStatus,
              ],
            ),
            returnValue: _i5.Future<List<_i6.CurriculumStatus>>.value(
                <_i6.CurriculumStatus>[]),
          ) as _i5.Future<List<_i6.CurriculumStatus>>);

  @override
  List<_i6.CurriculumStatus> setCompleteCurriculumStatus(
    List<_i6.CurriculumStatus>? listCurriculumStatus,
    bool? isLastCourse,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCompleteCurriculumStatus,
          [
            listCurriculumStatus,
            isLastCourse,
          ],
        ),
        returnValue: <_i6.CurriculumStatus>[],
      ) as List<_i6.CurriculumStatus>);
}

/// A class which mocks [FileRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFileRepository extends _i1.Mock implements _i7.FileRepository {
  MockFileRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.FileLocal get fileLocal => (super.noSuchMethod(
        Invocation.getter(#fileLocal),
        returnValue: _FakeFileLocal_1(
          this,
          Invocation.getter(#fileLocal),
        ),
      ) as _i3.FileLocal);

  @override
  _i5.Stream<int> saveFileFromUrl(
    String? url,
    String? fileName,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFileFromUrl,
          [
            url,
            fileName,
          ],
        ),
        returnValue: _i5.Stream<int>.empty(),
      ) as _i5.Stream<int>);

  @override
  _i5.Future<void> deleteFile(String? fileName) => (super.noSuchMethod(
        Invocation.method(
          #deleteFile,
          [fileName],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<bool> isFileExist(String? fileName) => (super.noSuchMethod(
        Invocation.method(
          #isFileExist,
          [fileName],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
