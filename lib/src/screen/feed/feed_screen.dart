import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/feed/video_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoManager>(builder: (_, model, __) {
      return Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              itemCount: model.videos.length,
              // allowImplicitScrolling: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                /// exxample
                final randomUser =
                    context.read<RandomUserManager>().users[index];

                return VideoView(
                  video: model.videos[index],
                  user: randomUser,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
