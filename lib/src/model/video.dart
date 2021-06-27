import 'dart:io';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class Video {
  Video({
    required this.videoUrl,
    required this.thumbUrl,
    required this.title,
    required this.shareCount,
    required this.favoriteCount,
  });

  Video.fromCurrentUser({
    required this.videoFile,
    required this.thumbnail,
    required this.title,
    this.shareCount = 0,
    this.favoriteCount = 0,
  });

  String id = Uuid().v4();
  String? videoUrl;
  String? thumbUrl;
  File? videoFile;
  Uint8List? thumbnail;
  String title;

  bool get fromSample => videoUrl != null && thumbUrl != null;

  int favoriteCount;
  int shareCount;
  bool isFavorite = false;
  bool isVisble = false;
}
