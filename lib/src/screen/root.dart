import 'package:car_app/src/extension/custom_dialog.dart';
import 'package:car_app/src/extension/overlay_loading_widget.dart';
import 'package:car_app/src/provider/random_user_manager.dart';
import 'package:car_app/src/screen/common/bottom_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RandomUserManager>(builder: (_, model, __) {
      return FutureBuilder(
        future: model.users.isEmpty ? model.fetchFirstUsers() : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return PlainLoadingWidget();
          }
          if (snapshot.error != null) {
            showErrorAlert(context, snapshot.error);
          }

          return BottomBarScreen();
        },
      );
    });
  }
}
