import 'package:car_app/src/model/user.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/screen/users/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<RandomUserManager>();

    return ListView.builder(
      itemCount: userModel.users.length,
      itemBuilder: (context, index) {
        final user = userModel.users[index];
        if (index == userModel.users.length - 1) {
          print("Pagination");
        }
        return _UserCell(user: user);
      },
    );
  }
}

class _UserCell extends StatelessWidget {
  const _UserCell({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: new Border(
          bottom: new BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.imageUrl),
          backgroundColor: Colors.grey,
        ),
        title: Text(user.fullname),
        subtitle: Text(user.email),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          Navigator.pushNamed(context, UserDetailScreen.routeName,
              arguments: user);
        },
      ),
    );
  }
}
