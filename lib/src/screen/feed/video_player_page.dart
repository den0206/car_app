import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/model/video.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({
    Key? key,
    required this.video,
    this.isPlaying = true,
    this.isInline = false,
  }) : super(key: key);

  final Video video;
  final bool isPlaying;
  final bool isInline;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.video.videoFile != null) {
      _videoController = VideoPlayerController.file(widget.video.videoFile!);
    } else {
      final String? videoUrl = widget.video.videoUrl;
      if (videoUrl == null) {
        return;
      }
      _videoController = VideoPlayerController.network(videoUrl);
    }
    await _videoController.initialize();

    if (widget.isPlaying) {
      await _videoController.play();
    }
    // await controller.setVolume(1);
    await _videoController.setLooping(true);

    setState(() {
      _isLoading = false;
    });

    if (widget.isInline)
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        aspectRatio: 3 / 2,
        autoPlay: widget.isPlaying,
        fullScreenByDefault: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
        ],
        placeholder: Container(
          color: Colors.black87,
          child: Container(
            child: Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )),
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !widget.isInline
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: !_isLoading
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        });
                      },
                      child: Stack(
                        children: [
                          VideoPlayer(_videoController),
                          AnimatedOpacity(
                            opacity:
                                !_videoController.value.isPlaying ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: Container(
                              color: !_videoController.value.isPlaying
                                  ? Color.fromRGBO(0, 0, 0, 0.3)
                                  : Colors.transparent,
                              child: Center(
                                child: Icon(
                                  _videoController.value.isPlaying
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
                      child: PlainLoadingWidget(),
                    ),
            )
          : !_isLoading && _chewieController != null
              ? Center(child: Chewie(controller: _chewieController!))
              : PlainLoadingWidget(),
    );
  }
}
