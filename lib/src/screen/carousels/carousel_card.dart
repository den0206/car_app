import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/extension/custom_button.dart';
import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/model/carousel_object.dart';
import 'package:flutter/material.dart';

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
          opaque: false,
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
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
      body: Hero(
        tag: "image + ${object.id}",
        child: GestureDetector(
          child: BackButtonWithStack(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
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
