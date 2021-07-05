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
  late AnimationController _animationController;
  Animation<double>? _animation;
  int index = 0;

  @override
  void initState() {
    super.initState();
    widget.images.shuffle();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              index += 1;

              if (index == widget.images.length) {
                index = 0;
              }
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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

class FadeinWidget extends StatefulWidget {
  FadeinWidget({
    Key? key,
    required this.child,
    this.duration,
  }) : super(key: key);

  final Widget child;
  final Duration? duration;

  @override
  _FadeinWidgetState createState() => _FadeinWidgetState();
}

class _FadeinWidgetState extends State<FadeinWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration == null
          ? Duration(milliseconds: 1000)
          : widget.duration,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          controller.stop();
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    animation.removeStatusListener((status) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}

class FanWidget extends StatefulWidget {
  FanWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _FanWidgetState createState() => _FanWidgetState();
}

class _FanWidgetState extends State<FanWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
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
    return RotationTransition(
      turns: Tween(begin: 0.1, end: -.1)
          .chain(CurveTween(curve: Curves.linear))
          .animate(controller),
      child: widget.child,
    );
  }
}
