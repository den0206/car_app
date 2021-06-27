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
    'https://media.istockphoto.com/photos/man-at-the-shopping-picture-id868718238?k=6&m=868718238&s=612x612&w=0&h=ZUPCx8Us3fGhnSOlecWIZ68y3H4rCiTnANtnjHk0bvo=',
    'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F0x0.jpg%3Ffit%3Dscale',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
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
      body: Stack(
        children: [
          AnimationBackground(images: images),
          Center(
            child: CustomGradientButton(
              title: "Upload",
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
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
