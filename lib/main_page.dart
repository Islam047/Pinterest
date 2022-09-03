import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pinterest/pages/navigation_page.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';

class MainPage extends StatefulWidget {
  static int? rowsEach;

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (_connectionStatus == ConnectivityResult.none) {
        showSimpleNotification(
          const Text("No internet Connection"),
          background: Colors.red,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == ConnectivityResult.none) {
      return const Scaffold(
        body: Center(
          child: Text(
            " ",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      );
    } else {
      return LayoutBuilder(builder: (context, boxConstraints) {
        int crossAxisCount = boxConstraints.maxWidth ~/ 250;
        MainPage.rowsEach = crossAxisCount;
        if (boxConstraints.maxWidth < 580) {
          // phone
          return const HomePage(crossAxisCount: 2);
        }
        if (boxConstraints.maxWidth < 1025) {
          // tablet
          return HomePage(crossAxisCount: MainPage.rowsEach!);
        } else {
          // desktop
          return HomePage(crossAxisCount: MainPage.rowsEach!);
        }
      });
    }
  }
}
