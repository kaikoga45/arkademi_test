import 'package:arkademi_test/commons/config/service_locator/service_locator.dart';
import 'package:arkademi_test/commons/enum/enum.dart';
import 'package:arkademi_test/data/api/courses_api.dart';
import 'package:arkademi_test/data/local/file_local.dart';
import 'package:arkademi_test/domain/entities/curriculum_status.dart';
import 'package:arkademi_test/domain/repositories/courses_repository.dart';
import 'package:arkademi_test/domain/repositories/file_repository.dart';
import 'package:arkademi_test/presentation/blocs/courses_status/courses_status_bloc.dart';
import 'package:arkademi_test/presentation/blocs/curriculum_status/curriculum_status_bloc.dart';
import 'package:arkademi_test/presentation/widgets/curriculum_tile_widget.dart';
import 'package:arkademi_test/presentation/widgets/loading_display_widget.dart';
import 'package:arkademi_test/presentation/widgets/progress_indicator_widget.dart';
import 'package:arkademi_test/presentation/widgets/section_tile_widget.dart';
import 'package:arkademi_test/presentation/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassroomPage extends StatelessWidget {
  const ClassroomPage({super.key});

  void _coursesStatusBlocListener(
      BuildContext context, CoursesStatusState state) {
    if (state is CoursesStatusLoaded) {
      context
          .read<CurriculumStatusBloc>()
          .add(CurriculumStatusFetch(state.coursesStatus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CoursesRepository(
            locator<CoursesApi>(),
            locator<FileLocal>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FileRepository(
            locator<FileLocal>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CoursesStatusBloc(
                RepositoryProvider.of<CoursesRepository>(context))
              ..add(CoursesStatusFetch()),
          ),
          BlocProvider(
            create: (context) => CurriculumStatusBloc(
                RepositoryProvider.of<CoursesRepository>(context)),
          ),
        ],
        child: BlocListener<CoursesStatusBloc, CoursesStatusState>(
          listener: _coursesStatusBlocListener,
          child: BlocBuilder<CurriculumStatusBloc, CurriculumStatusState>(
            builder: (context, state) {
              if (state is CurriculumStatusLoaded) {
                return const ClassroomContentPage(
                  key: Key('classroomContentPage'),
                );
              }
              return const LoadingDisplayWidget(
                key: Key('loadingDisplayWidget'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ClassroomContentPage extends StatelessWidget {
  const ClassroomContentPage({
    super.key,
  });

  String getCourseName(List<CurriculumStatus> curriculumStatus) =>
      curriculumStatus.where((e) => e.isCurrent == true).first.curriculum.title;

  void handleVideoEnd(
      BuildContext context, List<CurriculumStatus> curriculumStatus) {
    final isLastCourse =
        curriculumStatus.lastWhere((e) => e.isCurrent == true).key ==
            curriculumStatus.length;
    context
        .read<CurriculumStatusBloc>()
        .add(CurriculumStatusSetComplete(isLastCourse));
  }

  String getVideoPath(List<CurriculumStatus> curriculumStatus) {
    final curriculum = curriculumStatus.where((e) => e.isCurrent == true).first;
    if (curriculum.isOffline) {
      return curriculum.offlineVideoPath ?? '';
    }
    return curriculum.curriculum.onlineVideoLink ?? '';
  }

  VideoType getVideoType(List<CurriculumStatus> curriculumStatus) {
    final curriculum = curriculumStatus.where((e) => e.isCurrent == true).first;
    if (curriculum.isOffline) {
      return VideoType.file;
    }
    return VideoType.networkUrl;
  }

  @override
  Widget build(BuildContext context) {
    final coursesStatus =
        (context.read<CoursesStatusBloc>().state as CoursesStatusLoaded)
            .coursesStatus;
    final curriculumStatus =
        (context.watch<CurriculumStatusBloc>().state as CurriculumStatusLoaded)
            .curriculumStatus;

    final videoPath = getVideoPath(curriculumStatus);
    final videoType = getVideoType(curriculumStatus);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            coursesStatus.courseName,
            style: const TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ProgressIndicatorWidget(
                  progress: double.parse(coursesStatus.progress)),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: VideoPlayerWidget(
                videoPath: videoPath,
                videoType: videoType,
                onVideoEnd: () {
                  handleVideoEnd(context, curriculumStatus);
                },
              ),
            ),
            _CurrentSelectedCourseSection(
                courseName: getCourseName(curriculumStatus)),
            SliverPersistentHeader(
              delegate: _TabBarHeaderSection(),
              pinned: true,
            ),
            const SliverFillRemaining(
              child: TabBarView(
                children: [
                  _CurriculumTab(),
                  Tab(text: 'Ikhtisar'),
                  Tab(text: 'Lampiran'),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClassroomBottomNavBarPage(
          curriculumStatus: curriculumStatus,
        ),
      ),
    );
  }
}

class ClassroomBottomNavBarPage extends StatelessWidget {
  final List<CurriculumStatus> curriculumStatus;

  const ClassroomBottomNavBarPage({
    super.key,
    required this.curriculumStatus,
  });

  Widget getBackButton(BuildContext context) {
    switch (isBackButtonEnabled()) {
      case true:
        return InkWell(
          onTap: () => context.read<CurriculumStatusBloc>().add(
                CurriculumStatusUpdateCurrentSelectCourse(
                  backwardCurrentCurriculumStatus,
                ),
              ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.keyboard_double_arrow_left, color: Colors.black),
              Text('Sebelumnya', style: TextStyle(color: Colors.black))
            ],
          ),
        );
      case false:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.keyboard_double_arrow_left, color: Colors.grey),
            Text('Sebelumnya', style: TextStyle(color: Colors.grey))
          ],
        );
    }
  }

  getForwardButton(BuildContext context) {
    switch (isForwardButtonEnabled()) {
      case true:
        return InkWell(
          onTap: () => context.read<CurriculumStatusBloc>().add(
                CurriculumStatusUpdateCurrentSelectCourse(
                  forwardCurriculumStatus,
                ),
              ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selanjutnya', style: TextStyle(color: Colors.black)),
              Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.black,
              )
            ],
          ),
        );
      case false:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selanjutnya', style: TextStyle(color: Colors.grey)),
            Icon(Icons.keyboard_double_arrow_right, color: Colors.grey)
          ],
        );
    }
  }

  bool isForwardButtonEnabled() {
    return (currentIndex < curriculumStatus.length &&
            unitCurriculumStatus
                    .firstWhere((e) => e.key > currentIndex)
                    .isCompleted ==
                true) ||
        (currentIndex < curriculumStatus.length && currentCourseStatus);
  }

  CurriculumStatus get forwardCurriculumStatus =>
      unitCurriculumStatus.firstWhere((e) => e.key > currentIndex);

  CurriculumStatus get backwardCurrentCurriculumStatus =>
      unitCurriculumStatus.lastWhere((e) => e.key < currentIndex);

  bool isBackButtonEnabled() {
    return currentIndex > 1;
  }

  bool get currentCourseStatus =>
      unitCurriculumStatus.where((e) => e.isCurrent == true).first.isCompleted;

  int get currentIndex =>
      unitCurriculumStatus.where((e) => e.isCurrent == true).first.key;

  List<CurriculumStatus> get unitCurriculumStatus => curriculumStatus
      .where((e) => e.curriculum.type == CurriculumType.unit)
      .toList();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: getBackButton(context),
            ),
            const VerticalDivider(
              color: Colors.black,
            ),
            Expanded(
              child: getForwardButton(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurriculumTab extends StatelessWidget {
  const _CurriculumTab();

  @override
  Widget build(BuildContext context) {
    final curriculumStatus =
        (context.watch<CurriculumStatusBloc>().state as CurriculumStatusLoaded)
            .curriculumStatus;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final item = curriculumStatus[index];
        if (item.curriculum.type == CurriculumType.section) {
          return SectionTileWidget(
            title: item.curriculum.title,
            subtitle: item.curriculum.duration.toString(),
          );
        }
        return CurriculumTileWidget(curriculumStatus: item);
      },
      itemCount: curriculumStatus.length,
    );
  }
}

class _CurrentSelectedCourseSection extends StatelessWidget {
  final String courseName;

  const _CurrentSelectedCourseSection({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(courseName),
        ),
      ),
    );
  }
}

class _TabBarHeaderSection extends SliverPersistentHeaderDelegate {
  _TabBarHeaderSection();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const ColoredBox(
      color: Colors.white,
      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(text: 'Kurikulum'),
          Tab(text: 'Ikhtisar'),
          Tab(text: 'Lampiran'),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(_TabBarHeaderSection oldDelegate) {
    return false;
  }
}
