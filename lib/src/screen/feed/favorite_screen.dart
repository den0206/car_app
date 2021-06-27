import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/extension/auto_hide_top_bar_widget.dart';
import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FavoritsScreen extends StatelessWidget {
  FavoritsScreen({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();

  static const routeName = '/FavoritsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: FadeOnScroll(
              scrollController: _scrollController,
              fullOpacityOffset: 180,
              child: Text("Favorites"),
            ),
          ),
          Consumer<FavoriteManager>(builder: (_, model, __) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final video = model.favVideos[index];

                  return _VideoCell(video: video);
                },
                childCount: model.favVideos.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _VideoCell extends StatelessWidget {
  const _VideoCell({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkResponse(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: video.thumbUrl != null
              ? CachedNetworkImage(
                  imageUrl: video.thumbUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                      height: 50, width: 50, child: PlainLoadingWidget()),
                  errorWidget: (context, url, error) => Center(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Can't Read",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
                )
              : Image.memory(
                  video.thumbnail!,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
