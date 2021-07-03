import 'dart:io';

import 'package:car_app/src/extension/animation_background.dart';
import 'package:car_app/src/extension/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'confirm_screen.dart';

// ignore: must_be_immutable
class UploadScreen extends StatelessWidget {
  UploadScreen({Key? key}) : super(key: key);

  List<String> images = [
    "https://picsum.photos/200/300?grayscale",
    "https://picsum.photos/200/300/?blur",
    "https://picsum.photos/200/300?grayscale",
    "https://picsum.photos/200/300?grayscale",
  ];

  @override
  Widget build(BuildContext context) {
    Future<void> getVideo(ImageSource src) async {
      Navigator.of(context).pop();

      final video = await ImagePicker().getVideo(source: src);
      if (video == null) {
        return;
      }

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmScreen(
          videoFile: File(video.path),
          path: video.path,
          source: src,
        ),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          AnimationBackground(images: images),
          Center(
            child: CustomGradientButton(
              title: "Upload",
              endColor: Colors.pink,
              onPressed: () async {
                await showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey, Colors.white.withOpacity(0.0)],
                          stops: [
                            0.3,
                            0.9,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.videocam),
                              title: Text('Camera'),
                              onTap: () {
                                getVideo(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('Gallary'),
                              onTap: () {
                                getVideo(ImageSource.gallery);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.close),
                              title: Text('Cancel'),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
