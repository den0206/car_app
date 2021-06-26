import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/feed/video_player_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class VideoView extends StatelessWidget {
  const VideoView({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayerPage(video: video),
        VideoOverlayView(video: video),
        AnimatedOpacity(
          opacity: video.isFavorite ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          onEnd: () {
            context.read<VideoManager>().dismissAnimation(video);
          },
          curve: Curves.easeInBack,
          child: Visibility(
            visible: video.isVisble,
            child: Center(
              child: Icon(
                Icons.favorite,
                size: 150.0,
                color: Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class VideoOverlayView extends StatelessWidget {
  const VideoOverlayView({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

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
                      Row(
                        children: [
                          Icon(
                            Icons.music_note,
                            size: 15,
                            color: Colors.white,
                          ),
                        ],
                      )
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
                    _VideoIconButton(
                      text: "Comment",
                      icon: Icon(Icons.comment, size: 45, color: Colors.white),
                      onPressed: () {
                        print("Comment");
                      },
                    ),
                    _VideoIconButton(
                      text: "here",
                      icon: Icon(
                        Icons.reply,
                        size: 45,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print("Share");
                      },
                    ),
                    CirculeAnimation(
                      _AnimationProfile(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: CachedNetworkImage(
                  imageUrl:
                      "https://randomuser.me/api/portraits/med/men/${Random().nextInt(100)}.jpg",
                  placeholder: (context, url) => Icon(Icons.person),
                )

                // Icon(Icons.person),
                ),
          )
        ],
      ),
    );
  }
}
