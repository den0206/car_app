import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_app/src/model/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RandomUserManager>(builder: (_, model, __) {
      return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Uses'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: model.users.length - 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final User user = model.users[index];

                    return UserCell(user: user);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class UserCell extends StatelessWidget {
  const UserCell({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: user.imageUrl,
              // fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
