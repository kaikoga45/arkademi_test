import 'dart:io';

import 'package:arkademi_test/commons/enum/video_type.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  final VideoType videoType;
  final VoidCallback onVideoEnd;

  const VideoPlayerWidget({
    super.key,
    required this.videoPath,
    required this.videoType,
    required this.onVideoEnd,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  void _initializeVideoPlayer() {
    switch (widget.videoType) {
      case VideoType.networkUrl:
        controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
      case VideoType.file:
        controller = VideoPlayerController.file(File(widget.videoPath));
        break;
    }
    controller
      ..initialize().then((_) => setState(() {}))
      ..play()
      ..addListener(_videoListener);
  }

  void _videoListener() {
    if (controller.value.isInitialized &&
        (controller.value.duration == controller.value.position)) {
      widget.onVideoEnd();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath ||
        oldWidget.videoType != widget.videoType) {
      controller.dispose();
      _initializeVideoPlayer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        controller.value.isPlaying ? controller.pause() : controller.play();
      }),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: controller.value.isInitialized
                  ? VideoPlayer(controller)
                  : const ColoredBox(
                      color: Colors.grey,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            if (controller.value.isInitialized && !controller.value.isPlaying)
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
