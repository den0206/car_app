import 'dart:math';

import 'package:car_app/src/model/video.dart';

Random _random = Random();

List<Video> sampleVideos = [
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    title: "Big Buck Bunny",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
    title: "Big Buck Bunny",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
    title: "Big Buck Bunny",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
    title: "By Google",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
    title: "For Bigger Fun",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
    title: "For Bigger Joyrides",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerMeltdowns.jpg",
    title: "For Bigger Joyrides",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg",
    title: "Sintel",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/SubaruOutbackOnStreetAndDirt.jpg",
    title: "Subaru Outback On Street And Dirt",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg",
    title: "Tears of Steel",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/VolkswagenGTIReview.jpg",
    title: "Volkswagen GTI Review",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/WeAreGoingOnBullrun.jpg",
    title: "We Are Going On Bullrun",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
  Video(
    videoUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    thumbUrl:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/WhatCarCanYouGetForAGrand.jpg",
    title: "By Garage419",
    shareCount: _random.nextInt(100),
    favoriteCount: _random.nextInt(100),
  ),
];
