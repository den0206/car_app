import 'package:car_app/src/screen/feed/feed.dart';
import 'package:car_app/src/screen/upload/upload_screen.dart';
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
      Text("User"),
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
                icon: Icon(
                  Icons.home,
                ),
                label: "Feeds",
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                label: "Upload",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "User",
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          hoverElevation: 10,
          splashColor: Colors.grey,
          onPressed: () {
            model.setIndex(1);
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
