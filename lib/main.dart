import 'package:car_app/src/model/user.dart';
import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/common/bottom_tab.dart';
import 'package:car_app/src/screen/feed/favorite_screen.dart';
import 'package:car_app/src/screen/common/network_branch.dart';
import 'package:car_app/src/screen/inline/inline_detail_screen.dart';
import 'package:car_app/src/screen/users/user_detail_screen.dart';
import 'package:car_app/src/screen/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.greenAccent, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
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
              brightness: Brightness.dark,
            )),
        routes: {
          UsersScreen.routeName: (context) => UsersScreen(),
          FavoritsScreen.routeName: (context) => FavoritsScreen(),
        },

        /// with arguments
        onGenerateRoute: (settings) {
          if (settings.name == UserDetailScreen.routeName) {
            final user = settings.arguments as User;
            return MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: user),
            );
          }

          if (settings.name == InlineDetailScreen.routeName) {
            final video = settings.arguments as Video;
            return MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => InlineDetailScreen(video: video),
            );
          }
        },
        home: NetworkBranch(),
      ),
    );
  }
}
