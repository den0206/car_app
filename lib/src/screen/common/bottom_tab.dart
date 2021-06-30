import 'package:badges/badges.dart';
import 'package:car_app/src/data/consts_color.dart';
import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:car_app/src/screen/carousels/carousel_list.dart';
import 'package:car_app/src/screen/feed/feed_screen.dart';
import 'package:car_app/src/screen/upload/upload_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarModel with ChangeNotifier {
  int _currntIndex = 0;
  int get currentIndex => _currntIndex;

  void setIndex(int value) {
    _currntIndex = value;
    notifyListeners();
  }
}

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BottomBarModel>();

    List<Widget> _pages = [
      FeedScreen(),
      UploadScreen(),
      CarouselList(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[model.currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        clipBehavior: Clip.antiAlias,
        notchMargin: 0.1,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: model.setIndex,
            selectedItemColor: Colors.black,
            currentIndex: model.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Consumer<FavoriteManager>(builder: (_, model, __) {
                  return Badge(
                      badgeColor: ConstsColor.favBadgeColor,
                      animationType: BadgeAnimationType.slide,
                      showBadge: model.favVideos.length > 0,
                      toAnimate: true,
                      position: BadgePosition.topEnd(),
                      badgeContent: Text(
                        model.favVideos.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Icon(
                        Icons.home,
                      ));
                }),
                label: "Feeds",
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                label: "Upload",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.recent_actors),
                label: "Carousel",
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(3),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          hoverElevation: 10,
          splashColor: Colors.grey,
          onPressed: () {
            model.setIndex(1);
          },
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.white.withOpacity(0.0), Colors.red])),
          ),
        ),
      ),
    );
  }
}
