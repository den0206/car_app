import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/screen/users/user_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_app/src/data/consts_color.dart';
import 'package:car_app/src/model/user.dart';
import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/feed/video_player_page.dart';

import 'favorite_screen.dart';

class VideoView extends StatelessWidget {
  const VideoView({
    Key? key,
    required this.video,
    required this.user,
  }) : super(key: key);

  final Video video;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayerPage(video: video),
        VideoOverlayView(video: video, user: user),
        if (video.isFavorite && video.isVisble) FavoriteActionView()
      ],
    );
  }
}

class FavoriteActionView extends StatefulWidget {
  FavoriteActionView({Key? key}) : super(key: key);

  @override
  _FavoriteActionViewState createState() => _FavoriteActionViewState();
}

class _FavoriteActionViewState extends State<FavoriteActionView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);

    controller.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    animation.removeStatusListener((status) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Center(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: -.1)
              .chain(CurveTween(curve: Curves.elasticIn))
              .animate(controller),
          child: Icon(
            Icons.favorite,
            color: ConstsColor.favColor,
            size: 170,
          ),
        ),
      ),
    );
  }
}

class VideoOverlayView extends StatelessWidget {
  const VideoOverlayView({
    Key? key,
    required this.video,
    required this.user,
  }) : super(key: key);

  final Video video;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        video.title,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // _BuildProfile(url: ""),
                    _VideoIconButton(
                      text: "${video.favoriteCount} Likes",
                      icon: Icon(
                        Icons.favorite,
                        size: 45,
                        color: video.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        context.read<VideoManager>().manageFavorite(video);
                      },
                    ),
                    Consumer<FavoriteManager>(builder: (_, model, __) {
                      return Badge(
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
                            Icons.card_travel,
                            color: Colors.yellow.withOpacity(0.8),
                            size: 50,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, FavoritsScreen.routeName);
                          },
                        ),
                      );
                    }),

                    CirculeAnimation(
                      _AnimationProfile(user: user),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _VideoIconButton extends StatelessWidget {
  const _VideoIconButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class CirculeAnimation extends StatefulWidget {
  final Widget mychild;
  CirculeAnimation(this.mychild);

  @override
  _CirculeAnimationState createState() => _CirculeAnimationState();
}

class _CirculeAnimationState extends State<CirculeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.mychild,
    );
  }
}

class _AnimationProfile extends StatelessWidget {
  const _AnimationProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 60,
        height: 60,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    colors: [Colors.grey[800]!, Colors.grey[700]!]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Hero(
                  tag: "image${user.imageUrl}",
                  child: CachedNetworkImage(
                    imageUrl: user.imageUrl,
                    placeholder: (context, url) => Icon(Icons.person),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          UserDetailScreen.routeName,
          arguments: user,
        );
      },
    );
  }
}
