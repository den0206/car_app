import 'dart:math';
import 'package:car_app/src/extension/custom_button.dart';
import 'package:car_app/src/model/user.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/screen/users/user_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UsersCardScreen extends StatefulWidget {
  UsersCardScreen({Key? key}) : super(key: key);

  @override
  _UsersCardScreenState createState() => _UsersCardScreenState();
}

class _UsersCardScreenState extends State<UsersCardScreen> {
  final PageController _pageController =
      PageController(viewportFraction: 0.3, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final usersModel = context.watch<RandomUserManager>();

    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: usersModel.users.length,
      itemBuilder: (context, index) {
        return _animatedCard(index, usersModel.users[index]);
      },
    );
  }

  _animatedCard(int index, User user) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;

        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;

          if (value >= 0) {
            double _lowerLimit = 0.5;
            double _upperLimit = pi / 2.0;

            value = (_upperLimit - (value.abs() * (_upperLimit - _lowerLimit)))
                .clamp(_lowerLimit, _upperLimit);
            value = _upperLimit - value;
            value *= -1;
          }
        } else {
          //Won't work properly in case initialPage in changed in PageController
          if (index == 0) {
            value = 0;
          } else if (index == 1) {
            value = -1;
          }
        }
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(value),
          alignment: Alignment.center,
          child: _UsersCard(user: user),
        );
      },
    );
  }
}

class _UsersCard extends StatelessWidget {
  const _UsersCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, UserDetailScreen.routeName,
              arguments: user);
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Hero(
                      tag: "image${user.imageUrl}",
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipOval(
                          child: Image.network(user.imageUrl),
                        ),
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ImageButton(
                            imagePath: "assets/images/facebook_logo.png",
                            onTap: () {},
                            width: 30,
                          ),
                          ImageButton(
                            imagePath: "assets/images/linkedin_logo.png",
                            onTap: () {},
                            width: 30,
                          ),
                          ImageButton(
                            imagePath: "assets/images/instagram_logo.png",
                            onTap: () {},
                            width: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        user.fullname,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Spacer(),
                      Text(
                        user.email,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        user.phone,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
