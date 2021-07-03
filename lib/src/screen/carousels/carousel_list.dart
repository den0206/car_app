import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/extension/custom_button.dart';
import 'package:car_app/src/extension/overlay_loading_widget.dart';
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
        return Consumer<CarouselListModel>(builder: (_, model, __) {
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: Text('Crousels'),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(model.showIndicator ? "hide" : "show"),
                    Switch(
                        value: model.showIndicator,
                        onChanged: model.setIndicator,
                        activeTrackColor: Colors.black,
                        activeColor: Colors.black12)
                  ],
                )
              ],
            ),
            body: FutureBuilder(
              future: model.fetchFirstObjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    model.objects.isEmpty) return PlainLoadingWidget();

                return Column(
                  children: [
                    Spacer(),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: model.isLoading ? 1.0 : 0.0,
                      child: Text(
                        "Loading...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OriginCarousel(
                      model: model,
                    ),
                    Spacer(),
                  ],
                );
              },
            ),
          );
        });
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
    return Column(
      children: [
        Container(
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(10, (i) => i).map(
              (i) {
                // var index = widget.model.objects.indexOf(obj);
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: widget.model.showIndicator ? 1.0 : 0.0,
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

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    Key? key,
    required this.object,
  }) : super(key: key);

  final CarouselObject object;

  @override
  Widget build(BuildContext context) {
    final Size responsive = MediaQuery.of(context).size;
    return GestureDetector(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 32, left: 8, right: 8),
          child: Container(
            width: responsive.width * 0.7,
            height: responsive.height * 0.55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(5, 15),
                  blurRadius: 10,
                )
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: "image + ${object.id}",
                    child: CachedNetworkImage(
                      imageUrl: "https://picsum.photos/id/${object.id}/200/300",
                      placeholder: (context, url) => PlainLoadingWidget(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
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
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          fullscreenDialog: true,
          transitionDuration: Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ObjectDetailScreen(object: object),
        ));
        // ));
      },
    );
  }
}

class ObjectDetailScreen extends StatelessWidget {
  const ObjectDetailScreen({
    Key? key,
    required this.object,
  }) : super(key: key);

  final CarouselObject object;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: "image + ${object.id}",
        child: GestureDetector(
          child: BackButtonWithStack(
            child: Center(
              child: SizedBox(
                width: 500,
                height: 650,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: "https://picsum.photos/id/${object.id}/200/300",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: object.author,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
