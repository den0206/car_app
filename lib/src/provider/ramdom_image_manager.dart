import 'dart:convert';

import 'package:car_app/src/model/carousel_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarouselListModel with ChangeNotifier {
  List<CarouselObject> objects = [];
  int currentPage = 2;
  int perPage = 10;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _showIndicator = true;
  bool get showIndicator => _showIndicator;
  void setIndicator(bool value) {
    _showIndicator = value;
    notifyListeners();
  }

  fetchFirstObjects() async {
    if (objects.isEmpty) {
      final jsonData = await _getResponse();

      for (Map<String, dynamic> json in jsonData) {
        final obj = CarouselObject.fromJson(json);
        objects.add(obj);
      }

      currentPage++;
    }
  }

  fetchMoreObjects() async {
    isLoading = true;

    try {
      print("pagination");
      final jsonData = await _getResponse();

      for (Map<String, dynamic> json in jsonData) {
        final obj = CarouselObject.fromJson(json);
        objects.add(obj);
      }

      isLoading = false;
      currentPage++;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<dynamic> _getResponse() async {
    final dataFromUrl =
        "https://picsum.photos/v2/list?page=$currentPage&limit=$perPage";

    final uri = Uri.parse(dataFromUrl);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return;
    }

    final jsonData = json.decode(response.body);
    return jsonData;
  }
}
