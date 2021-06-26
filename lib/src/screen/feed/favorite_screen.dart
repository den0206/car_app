import 'package:car_app/src/provider/favorite_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritsScreen extends StatelessWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  static const routeName = '/FavoriteScreen';

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteManager>(builder: (_, model, __) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Center(
          child: Text(
            model.favVideos.length.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }
}
