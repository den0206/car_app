import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/bottom_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarModel>(
          create: (context) => BottomBarModel(),
        ),
        ChangeNotifierProvider<VideoManager>(
          create: (context) => VideoManager(),
        ),
        ChangeNotifierProxyProvider<VideoManager, FavoriteManager>(
          create: (context) => FavoriteManager(),
          lazy: false,
          update: (context, videoManager, favoriteManager) =>
              favoriteManager!..updateVideoManager(videoManager),
        )
      ],
      child: MaterialApp(
        title: "Car App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: BottomBarScreen(),
      ),
    );
  }
}
