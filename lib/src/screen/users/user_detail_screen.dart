import 'dart:math';

import 'package:car_app/src/extension/custom_button.dart';
import 'package:car_app/src/model/video.dart';
import 'package:car_app/src/provider/video_manager.dart';
import 'package:car_app/src/screen/feed/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_app/src/model/user.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  static const routeName = '/UserDetailScreen';
  final User user;

  @override
  Widget build(BuildContext context) {
    final Size responsiveSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullname),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  height: responsiveSize.height * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/500/200",
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: EdgeInsets.only(top: responsiveSize.height * 0.15),
                    child: Card(
                      elevation: 5.0,
                      color: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.only(
                            top: responsiveSize.height * 0.13,
                            bottom: responsiveSize.height * 0.03),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              user.fullname,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: responsiveSize.height * 0.02,
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              user.phone,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: responsiveSize.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ImageButton(
                                  imagePath: "assets/images/facebook_logo.png",
                                  onTap: () {},
                                ),
                                ImageButton(
                                  imagePath: "assets/images/linkedin_logo.png",
                                  onTap: () {},
                                ),
                                ImageButton(
                                  imagePath: "assets/images/instagram_logo.png",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 10.0,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: responsiveSize.height * 0.02),
                    child: new Center(
                      child: Hero(
                        tag: "image${user.imageUrl}",
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 100.0,
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Consumer<VideoManager>(builder: (_, model, __) {
              return Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: Random().nextInt(model.videos.length - 1),
                  padding: EdgeInsets.all(4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    Video video = model.videos[index];

                    return VideoCell(video: video);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
