import 'package:car_app/src/model/video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController controller;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.video.videoFile != null) {
      controller = VideoPlayerController.file(widget.video.videoFile!)
        ..initialize().then((value) {
          controller.play();
          controller.setVolume(1);
          controller.setLooping(true);
          setState(() {
            isLoading = false;
          });
        });
    } else {
      final String? videoUrl = widget.video.videoUrl;

      controller = VideoPlayerController.network(videoUrl!)
        ..initialize().then((value) {
          controller.play();
          controller.setVolume(1);
          controller.setLooping(true);

          setState(() {
            isLoading = false;
          });
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? GestureDetector(
              onTap: () {
                setState(() {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                });
              },
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: VideoPlayer(controller),
                  ),
                  // if (!controller.value.isPlaying)
                  AnimatedOpacity(
                    opacity: !controller.value.isPlaying ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Center(
                      child: Icon(
                        controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 100.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
    );
  }
}
