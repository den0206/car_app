import 'dart:convert';

import 'package:car_app/src/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// API from https://randomuser.me/

class RandomUserManager with ChangeNotifier {
  List<User> users = [];
  int currentPage = 0;

  fetchRandomUsers() async {
    if (users.length == 0) {
      final jsonData = await _getResponse(perPage: 20);

      for (Map<String, dynamic> json in jsonData[UserKey.results]) {
        final randomUser = User.fromJson(json);
        users.add(randomUser);
      }

      currentPage++;

      notifyListeners();
    }
  }

  Future<dynamic> _getResponse({int perPage = 10}) async {
    final dataFromUrl =
        "https://randomuser.me/api/?page=$currentPage&results=$perPage";
    final uri = Uri.parse(dataFromUrl);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return;
    }
    final jsonData = json.decode(response.body);
    return jsonData;
  }
}
