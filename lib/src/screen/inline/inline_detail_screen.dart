import 'dart:math';

import 'package:car_app/src/extension/custom_button.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/feed/video_view.dart';
import 'package:flutter/material.dart';

import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/screen/feed/video_player_page.dart';
import 'package:provider/provider.dart';

class InlineDetailScreen extends StatelessWidget {
  InlineDetailScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  static const routeName = '/InlineDetailScreen';

  final Video video;
  final userIndex = Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<VideoManager>();
    final randomUser = context.read<RandomUserManager>().users[userIndex];

    return Scaffold(
      body: BackButtonWithStack(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: VideoPlayerPage(
                    video: video,
                    showThumbnail: true,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 3,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(randomUser.imageUrl),
                        backgroundColor: Colors.grey,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              model.manageFavorite(video);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color:
                                  video.isFavorite ? Colors.red : Colors.grey,
                              size: 40,
                            ),
                          ),
                          Text(
                            video.favoriteCount.toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          Text(
                            video.shareCount.toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          video.title,
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (video.isFavorite && video.isVisble) FavoriteActionView()
          ],
        ),
      ),
    );
  }
}
