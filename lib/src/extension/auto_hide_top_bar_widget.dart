import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AutohideTopBarWidget extends StatefulWidget {
  const AutohideTopBarWidget({
    Key? key,
    required this.appBar,
    required this.body,
  }) : super(key: key);

  final AppBar appBar;
  final Widget body;

  @override
  _AutohideTopBarWidgetState createState() => _AutohideTopBarWidgetState();
}

class _AutohideTopBarWidgetState extends State<AutohideTopBarWidget> {
  ScrollController _scrollController = ScrollController();
  bool _isScrollDown = false;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (!_isScrollDown) {
            _isScrollDown = true;
            setState(() {
              _showAppBar = false;
            });
          }
        }

        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isScrollDown) {
            _isScrollDown = false;
            setState(() {
              _showAppBar = true;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        AnimatedOpacity(
          opacity: _showAppBar ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: widget.appBar,
          ),
        )
      ],
    );
  }
}

class FadeOnScroll extends StatefulWidget {
  FadeOnScroll({
    Key? key,
    required this.scrollController,
    required this.child,
    this.zeroOpacityOffset = 0,
    this.fullOpacityOffset = 0,
  });
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  @override
  _FadeOnScrollState createState() => _FadeOnScrollState();
}

class _FadeOnScrollState extends State<FadeOnScroll> {
  late double _offset;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  double _calculateOpacity() {
    if (widget.fullOpacityOffset == widget.zeroOpacityOffset)
      return 1;
    else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {
      // fading in
      if (_offset <= widget.zeroOpacityOffset)
        return 0;
      else if (_offset >= widget.fullOpacityOffset)
        return 1;
      else
        return (_offset - widget.zeroOpacityOffset) /
            (widget.fullOpacityOffset - widget.zeroOpacityOffset);
    } else {
      // fading out
      if (_offset <= widget.fullOpacityOffset)
        return 1;
      else if (_offset >= widget.zeroOpacityOffset)
        return 0;
      else
        return (_offset - widget.fullOpacityOffset) /
            (widget.zeroOpacityOffset - widget.fullOpacityOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: widget.child,
    );
  }
}
