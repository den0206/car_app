import 'package:badges/badges.dart';
import 'package:car_app/src/data/consts_color.dart';
import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/feed/favorite_screen.dart';
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
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return VideoView(video: model.videos[index]);
              },
            ),
            Consumer<FavoriteManager>(builder: (_, model, __) {
              return Positioned(
                top: 20,
                right: 40,
                child: Badge(
                  badgeColor: ConstsColor.favBadgeColor,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(top: 4, end: -4),
                  badgeContent: Text(
                    model.favVideos.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.pink.withOpacity(0.4),
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, FavoritsScreen.routeName);
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
