import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_app/src/model/carousel_object.dart';
import 'package:car_app/src/provider/ramdom_image_manager.dart';

class CarouselList extends StatelessWidget {
  const CarouselList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarouselListModel>(
      create: (context) => CarouselListModel(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            title: Text('Crousels'),
          ),
          body: Consumer<CarouselListModel>(
            builder: (_, model, __) {
              return FutureBuilder(
                future: model.fetchFirstObjects(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          if (model.isLoading)
                            Text(
                              "Loading...",
                              style: TextStyle(color: Colors.white),
                            ),
                          OriginCarousel(
                            model: model,
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class OriginCarousel extends StatefulWidget {
  OriginCarousel({
    Key? key,
    required this.model,
  }) : super(key: key);

  final CarouselListModel model;

  @override
  _OriginCarouselState createState() => _OriginCarouselState();
}

class _OriginCarouselState extends State<OriginCarousel> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: PageView.builder(
        itemCount: widget.model.objects.length,
        allowImplicitScrolling: true,
        controller: PageController(
          initialPage: 0,
          viewportFraction: 0.75,
        ),
        onPageChanged: (index) {
          setState(
            () {
              currentPage = index;
            },
          );

          /// paging
          if (index == widget.model.objects.length - 2) {
            widget.model.fetchMoreObjects();
          }
        },
        itemBuilder: (context, index) {
          return Opacity(
            opacity: currentPage == index ? 1.0 : 0.65,
            child: CarouselCard(
              object: widget.model.objects[index],
            ),
          );
        },
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    Key? key,
    required this.object,
  }) : super(key: key);

  final CarouselObject object;

  @override
  Widget build(BuildContext context) {
    final Size responsive = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 32, left: 8, right: 8),
        child: Container(
          width: responsive.width * 0.7,
          height: responsive.height * 0.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image:
                  NetworkImage("https://picsum.photos/id/${object.id}/200/300"),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(5, 15),
                blurRadius: 10,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 30,
                  height: 30,
                  child: FlutterLogo(),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      object.author,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Container(
                    //     height: 100,
                    //     width: responsive.width * 0.6,
                    //     child: Text(
                    //       "Description",
                    //       style: TextStyle(color: Colors.white),
                    //       textAlign: TextAlign.end,
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 5,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
