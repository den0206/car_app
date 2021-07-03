import 'package:flutter/material.dart';

import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/screen/feed/video_player_page.dart';

class InlineDetailScreen extends StatelessWidget {
  const InlineDetailScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  static const routeName = '/InlineDetailScreen';

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayerPage(
        video: video,
        height: 200,
      ),
    );
  }
}
