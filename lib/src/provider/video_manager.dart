import 'package:car_app/src/data/sampleVideo.dart';
import 'package:car_app/src/model/video.dart';
import 'package:flutter/material.dart';

class VideoManager with ChangeNotifier {
  List<Video> _videos = [];
  List<Video> get videos => _videos;

  VideoManager() {
    _loadSampleVideo();
  }

  void _loadSampleVideo() {
    _videos = sampleVideos;
    notifyListeners();
  }

  void addVideo(Video video) {
    _videos.insert(0, video);
    notifyListeners();
  }

  void manageFavorite(Video video) {
    final a = _videos.where((v) => v.id == video.id).first;
    a.isFavorite ? a.favoriteCount -= 1 : a.favoriteCount += 1;
    a.isFavorite = !a.isFavorite;
    a.isVisble = a.isFavorite;

    notifyListeners();
  }

  void dismissAnimation(Video video) {
    if (video.isVisble) {
      Future.delayed(Duration(milliseconds: 1000)).then(
        (_) {
          video.isVisble = false;
          notifyListeners();
        },
      );
    }
  }
}
