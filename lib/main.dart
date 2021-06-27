import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/bottom_tab.dart';
import 'package:car_app/src/screen/feed/favorite_screen.dart';
import 'package:car_app/src/screen/network_branch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RandomUserManager>(
          create: (context) => RandomUserManager(),
        ),
        ChangeNotifierProvider<BottomBarModel>(
          create: (context) => BottomBarModel(),
        ),
        ChangeNotifierProvider<VideoManager>(
          create: (context) => VideoManager(),
        ),
        ChangeNotifierProxyProvider<VideoManager, FavoriteManager>(
          create: (context) => FavoriteManager(),
          lazy: false,
          update: (context, videoManager, FavoriteManager? favoriteManager) =>
              favoriteManager!..updateVideoManager(videoManager),
        )
      ],
      child: MaterialApp(
        title: "Car App",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey,
            )),
        routes: {
          FavoritsScreen.routeName: (context) => FavoritsScreen(),
        },
        home: NetworkBranch(),
      ),
    );
  }
}
