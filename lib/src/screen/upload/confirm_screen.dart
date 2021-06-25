import 'dart:io';
import 'dart:typed_data';

import 'package:car_app/src/extension/custom_button.dart';
import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../bottom_tab.dart';
import 'custom_textfields.dart';

class ConfirmScreenModel with ChangeNotifier {
  File videoFile;
  String path;

  late VideoPlayerController controller;
  TextEditingController titleController = TextEditingController();
  String get title => titleController.text;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ConfirmScreenModel({required this.videoFile, required this.path}) {
    this.controller = VideoPlayerController.file(videoFile);

    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);

    notifyListeners();
  }

  Future uploadVideo({
    required Function(Video video) onSuccess,
    required Function(dynamic e) onFail,
  }) async {
    if (title.isEmpty) {
      Exception error = Exception("Please fill Title");
      onFail(error);
      return;
    }

    isLoading = true;

    await Future.delayed(Duration(seconds: 3));

    try {
      final Uint8List? thumbList = await VideoThumbnail.thumbnailData(
        video: videoFile.path,
      );

      if (thumbList == null) {
        return;
      }
      final thumbnail = File.fromRawPath(thumbList);

      final video = Video.fromCurrentUser(
          videoFile: videoFile, thumbnail: thumbnail, title: title);

      onSuccess(video);
    } catch (e) {
      onFail(e);
    } finally {
      isLoading = false;
    }
  }
}

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.path,
    required this.source,
  }) : super(key: key);

  final File videoFile;
  final String path;
  final ImageSource source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ChangeNotifierProvider<ConfirmScreenModel>(
        create: (context) =>
            ConfirmScreenModel(videoFile: videoFile, path: path),
        builder: (context, snapshot) {
          return Consumer<ConfirmScreenModel>(builder: (_, model, __) {
            return OverlayLoadingWidget(
              isLoading: model.isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: BackButtonWithStack(
                        child: VideoPlayer(model.controller),
                        onPop: () {
                          Navigator.of(context).pop();
                          videoFile.delete();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: CustomTextFields(
                        controller: model.titleController,
                        labelText: "Title",
                      ),
                    ),
                    CustomButton(
                      title: "Upload",
                      onPressed: () {
                        model.uploadVideo(
                          onSuccess: (video) {
                            Navigator.of(context).pop();
                            context.read<VideoManager>().addVideo(video);
                            context.read<BottomBarModel>().setIndex(0);
                          },
                          onFail: (e) {
                            print(e);
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
