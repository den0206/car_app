import 'dart:async';

import 'package:car_app/src/screen/common/no_wifi_screen.dart';
import 'package:car_app/src/screen/root.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkBranch extends StatefulWidget {
  NetworkBranch({Key? key}) : super(key: key);

  @override
  _NetworkBranchState createState() => _NetworkBranchState();
}

class _NetworkBranchState extends State<NetworkBranch> {
  InternetConnectionStatus _connectionStatus =
      InternetConnectionStatus.disconnected;
  final InternetConnectionChecker _connectivity = InternetConnectionChecker();
  late StreamSubscription<InternetConnectionStatus> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    _connectivitySubscription =
        _connectivity.onStatusChange.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(InternetConnectionStatus result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_connectionStatus) {
      case InternetConnectionStatus.connected:
        return Root();
      case InternetConnectionStatus.disconnected:
        return NoWifiScreen();
    }
  }
}
