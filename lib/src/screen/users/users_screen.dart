import 'package:car_app/src/screen/users/users_card_screen.dart';
import 'package:car_app/src/screen/users/users_list_screen.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);
  static const routeName = '/UsersScreen';

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabView = [UsersListScreen(), UsersCardScreen()];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Users'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: Container(
              child: TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(child: Text("List", style: TextStyle(fontSize: 20.0))),
                  Tab(child: Text("Card", style: TextStyle(fontSize: 20.0))),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: _tabView,
        ),
      ),
    );
  }
}
