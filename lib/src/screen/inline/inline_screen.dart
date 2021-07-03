import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/inline/inline_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InlineScreen extends StatelessWidget {
  const InlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoManager>(builder: (_, model, __) {
        return ListView.builder(
          itemCount: model.videos.length,
          itemBuilder: (context, index) {
            final video = model.videos[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, InlineDetailScreen.routeName,
                    arguments: video);
              },
              child: Stack(
                children: [
                  video.thumbUrl != null
                      ? CachedNetworkImage(
                          imageUrl: video.thumbUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.memory(
                          video.thumbnail!,
                          fit: BoxFit.cover,
                        ),
                  Container(
                    width: double.infinity,
                    height: 200,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      video.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(128, 0, 0, 0),
                            offset: const Offset(0, 2.0),
                            blurRadius: 0.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
