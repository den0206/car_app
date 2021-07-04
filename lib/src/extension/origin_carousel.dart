// ignore: must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OriginCarousel extends StatefulWidget {
  OriginCarousel({
    Key? key,
    this.showIndicator = true,
    this.onChange,
    required this.itemCount,
    required this.controller,
    required this.itemBuilder,
  }) : super(key: key);

  final PageController controller;
  final bool showIndicator;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  Function(int index)? onChange;

  @override
  _OriginCarouselState createState() => _OriginCarouselState();
}

class _OriginCarouselState extends State<OriginCarousel> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      currentPage = widget.controller.initialPage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: PageView.builder(
              itemCount: widget.itemCount,
              // allowImplicitScrolling: true,
              controller: widget.controller,
              onPageChanged: (index) {
                setState(
                  () {
                    currentPage = index;
                  },
                );

                if (widget.onChange != null) {
                  widget.onChange!(index);
                }
              },
              itemBuilder: widget.itemBuilder),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.itemCount < 10 ? widget.itemCount : 10, (i) => i).map(
              (i) {
                // var index = widget.model.objects.indexOf(obj);
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: widget.showIndicator ? 1.0 : 0.0,
                  child: Container(
                    width: 7,
                    height: 7,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          currentPage % 10 == i ? Colors.black : Colors.white,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
