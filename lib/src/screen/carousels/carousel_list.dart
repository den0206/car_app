import 'package:car_app/src/extension/origin_carousel.dart';
import 'package:car_app/src/screen/carousels/carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/provider/ramdom_image_manager.dart';

class CarouselList extends StatelessWidget {
  const CarouselList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarouselListModel>(
      create: (context) => CarouselListModel(),
      builder: (context, snapshot) {
        return Consumer<CarouselListModel>(builder: (_, model, __) {
          double getOpacity(int index) {
            int currentIndex;
            try {
              currentIndex = model.pageController.page!
                  .round(); // an object of PageController
            } catch (e) {
              currentIndex = model.pageController.initialPage;
            }

            return currentIndex == index ? 1.0 : 0.65;
          }

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
                      itemCount: model.objects.length,
                      showIndicator: model.showIndicator,
                      controller: model.pageController,
                      onChange: (index) {
                        /// pagination
                        if (index == model.objects.length - 2) {
                          model.fetchMoreObjects();
                        }
                      },
                      itemBuilder: (context, index) {
                        return Opacity(
                          opacity: getOpacity(index),
                          child: CarouselCard(
                            object: model.objects[index],
                          ),
                        );
                      },
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
