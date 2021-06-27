import 'dart:convert';

import 'package:car_app/src/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// API from https://randomuser.me/

class RandomUserManager with ChangeNotifier {
  List<User> users = [];

  fetchRandomUsers() async {
    if (users.length == 0) {
      final dataFromUrl = "https://randomuser.me/api/?results=20";
      final uri = Uri.parse(dataFromUrl);
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        return;
      }

      final jsonData = json.decode(response.body);

      for (Map<String, dynamic> json in jsonData[UserKey.results]) {
        final randomUser = User.fromJson(json);
        users.add(randomUser);
      }

      notifyListeners();
    }
  }
}
