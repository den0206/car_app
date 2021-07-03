import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/model/video.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({
    Key? key,
    required this.video,
    this.showThumbnail = false,
  }) : super(key: key);

  final Video video;
  final bool showThumbnail;

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !isLoading
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
                    VideoPlayer(controller),
                    AnimatedOpacity(
                      opacity: !controller.value.isPlaying ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        color: !controller.value.isPlaying
                            ? Color.fromRGBO(0, 0, 0, 0.3)
                            : Colors.transparent,
                        child: Center(
                          child: Icon(
                            controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 100.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: widget.showThumbnail
                    ? widget.video.thumbUrl != null
                        ? CachedNetworkImage(
                            imageUrl: widget.video.thumbUrl!,
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            widget.video.thumbnail!,
                            fit: BoxFit.cover,
                          )
                    : PlainLoadingWidget()),
      ),
    );
  }
}
