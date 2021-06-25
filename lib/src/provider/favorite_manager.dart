import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:flutter/material.dart';

class FavoriteManager with ChangeNotifier {
  List<Video> _favVideos = [];
  List<Video> get favVideos => _favVideos;
  late VideoManager videoManager;

  void updateVideoManager(VideoManager manager) {
    this.videoManager = manager;

    if (videoManager.videos.isNotEmpty) {
      _favVideos =
          videoManager.videos.where((v) => v.isFavorite == true).toList();

      notifyListeners();
    }
  }
}
