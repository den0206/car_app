import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkStatus { Online, Offline }

class NetworkManager {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  InternetConnectionChecker _internetChecker = InternetConnectionChecker();

  NetworkManager() {
    _internetChecker.onStatusChange.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(InternetConnectionStatus status) {
    return status == InternetConnectionStatus.connected
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }
}
