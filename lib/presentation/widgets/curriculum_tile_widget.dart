import 'package:arkademi_test/domain/entities/curriculum_status.dart';
import 'package:arkademi_test/domain/repositories/file_repository.dart';
import 'package:arkademi_test/presentation/blocs/courses_video/courses_video_bloc.dart';
import 'package:arkademi_test/presentation/blocs/curriculum_status/curriculum_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurriculumTileWidget extends StatelessWidget {
  final CurriculumStatus curriculumStatus;

  const CurriculumTileWidget({
    super.key,
    required this.curriculumStatus,
  });

  void showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF393A3C),
      context: context,
      builder: (modalBottomSheetContext) => InkWell(
        onTap: () => deleteVideo(modalBottomSheetContext),
        child: SafeArea(
          child: InkWell(
            onTap: () {
              deleteVideo(context);
              Navigator.pop(modalBottomSheetContext);
            },
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(Icons.delete_forever_outlined, color: Colors.white),
                  SizedBox(width: 5.0),
                  Text(
                    'Hapus dari Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteVideo(BuildContext context) =>
      context.read<CoursesVideoBloc>().add(
            CoursesVideoDelete(
              curriculumStatus.curriculum.title,
            ),
          );

  void downloadVideo(BuildContext context) {
    context.read<CoursesVideoBloc>().add(
          CoursesVideoDownload(
            curriculumStatus.curriculum.offlineVideoLink ?? '',
            curriculumStatus.curriculum.title,
          ),
        );
  }

  void updateCurrentSelectCourse(BuildContext context) =>
      context.read<CurriculumStatusBloc>()
        ..add(CurriculumStatusUpdateCurrentSelectCourse(curriculumStatus));

  void _coursesVideoBlocListener(
    BuildContext context,
    CoursesVideoState state,
  ) {
    if (state is CoursesVideoFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
        ),
      );
    } else if (state is CoursesVideoDownloaded) {
      context.read<CurriculumStatusBloc>().add(
            CurriculumStatusUpdateCurrentOfflineVideoStatus(
                curriculumStatus.copyWith(isOffline: true)),
          );
    } else if (state is CoursesVideoDeleted) {
      context.read<CurriculumStatusBloc>().add(
            CurriculumStatusUpdateCurrentOfflineVideoStatus(
                curriculumStatus.copyWith(isOffline: false)),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) {
        final repositories = RepositoryProvider.of<FileRepository>(context);
        return CoursesVideoBloc(repositories);
      },
      child: BlocListener<CoursesVideoBloc, CoursesVideoState>(
        listener: _coursesVideoBlocListener,
        child: InkWell(
          onTap: curriculumStatus.isCurrent || curriculumStatus.isCompleted
              ? () => updateCurrentSelectCourse(context)
              : null,
          child: ListTile(
            tileColor: curriculumStatus.isCurrent
                ? const Color(0xFFEBF6FF)
                : Colors.white,
            leading: curriculumStatus.isCompleted
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.play_arrow),
            minLeadingWidth: 20.0,
            title: Text(
              curriculumStatus.curriculum.title,
              style: TextStyle(
                fontSize: textTheme.titleMedium?.fontSize ?? 16.0,
              ),
            ),
            subtitle: Text('${curriculumStatus.curriculum.duration} Menit'),
            trailing: BlocBuilder<CoursesVideoBloc, CoursesVideoState>(
                builder: (context, state) {
              if (state is CoursesVideoDownloadProgress) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: const Color(0xFF006AAF),
                  ),
                  onPressed: null,
                  child: Text(
                    'Progress.. ${state.progress}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (curriculumStatus.isOffline) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () => showDeleteConfirmation(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tersimpan',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5.0),
                      Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                    ],
                  ),
                );
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006AAF),
                ),
                onPressed: () => downloadVideo(context),
                child: const Text('Tonton Offline'),
              );
            }),
          ),
        ),
      ),
    );
  }
}
