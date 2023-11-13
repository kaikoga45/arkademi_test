import 'package:arkademi_test/data/api/courses_api.dart';
import 'package:arkademi_test/data/local/file_local.dart';
import 'package:arkademi_test/presentation/widgets/loading_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:arkademi_test/presentation/pages/classroom_page.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/courses_data_test.dart';
import '../mocks/api_test.mocks.dart';
import '../mocks/bloc_test.mocks.dart';
import '../mocks/local_test.mocks.dart';
import '../mocks/repositories_test.mocks.dart';

void main() {
  final curriculumStatusBloc = MockCurriculumStatusBloc();
  final coursesStatusBloc = MockCoursesStatusBloc();

  final coursesRepository = MockCoursesRepository();
  final fileRepository = MockCoursesRepository();

  final mockCoursesApi = MockCoursesApi();
  final mockFileLocal = MockFileLocal();

  setUpAll(() async {
    await dotenv.load(
      fileName: '.env',
    );

    final locator = GetIt.instance;

    locator
      ..registerSingleton<CoursesApi>(mockCoursesApi)
      ..registerSingleton<FileLocal>(mockFileLocal);
  });

  Widget makeTestableWidget({required Widget child}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => coursesRepository,
        ),
        RepositoryProvider(
          create: (_) => fileRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => curriculumStatusBloc,
          ),
          BlocProvider(
            create: (_) => coursesStatusBloc,
          ),
        ],
        child: MaterialApp(
          home: child,
        ),
      ),
    );
  }

  group('ClassroomPage', () {
    testWidgets(
        'shows LoadingDisplayWidget when state is not CurriculumStatusLoaded',
        (WidgetTester tester) async {
      when(mockCoursesApi.getCoursesStatus())
          .thenAnswer((_) async => coursesStatusDummyModelData);

      when(mockFileLocal.isFileExist(any)).thenAnswer((_) async => true);

      when(mockFileLocal.getFilePath(any)).thenAnswer((_) async => '123.mp4');

      await tester.pumpWidget(makeTestableWidget(
        child: const ClassroomPage(),
      ));

      expect(find.byType(LoadingDisplayWidget), findsOneWidget);
    });
  });
}
