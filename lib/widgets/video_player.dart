import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import '../styles/theme.dart';

class Video extends StatefulWidget {
  final String url;
  final bool stopVideo;
  final VoidCallback onVideoStopped;
  const Video({
    super.key,
    required this.url,
    required this.stopVideo,
    required this.onVideoStopped,
  });

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      widget.url,
    );

    initializeVideoPlayerFuture = controller.initialize();
    controller.play();
    //controller.setVolume(0);
    controller.setLooping(false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Borders.borderRadius20,
      child: FutureBuilder(
        future: initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.stopVideo) {
              controller.pause();
              widget.onVideoStopped();
            }
            return AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
