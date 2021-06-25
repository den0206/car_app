import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimationBackground extends StatefulWidget {
  AnimationBackground({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;
  @override
  _AnimationBackgroundState createState() => _AnimationBackgroundState();
}

class _AnimationBackgroundState extends State<AnimationBackground>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  int index = 0;

  @override
  void initState() {
    super.initState();
    widget.images.shuffle();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              index += 1;

              if (index == widget.images.length) {
                index = 0;
              }
              _animationController?.reset();
              _animationController?.forward();
            }
          });
    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animation == null) {
      return Container();
    }
    return CachedNetworkImage(
      imageUrl: widget.images[index],
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: FractionalOffset(_animation!.value, 0),
    );
  }
}
