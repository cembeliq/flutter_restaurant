import 'dart:io';

import 'package:dicoding_restaurant_app/utils/connection_state.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider() {
    getConnectivity();
  }

  Map _data = new Map();
  ConnectivityState _state;

  ConnectivityState get state => _state;

  Map get data => _data;

  void getConnectivity() {
    _checkConectivity();
  }

  Future<dynamic> _checkConectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _state = ConnectivityState.Connected;
        notifyListeners();
        _data['content'] = "Connected to the internet";
        _data['title'] = "You are good to go";
        return _data;
      }
    } on SocketException catch (_) {
      _state = ConnectivityState.NotConnected;
      notifyListeners();
      print("not connected");
      _data['title'] = "You are disconnected to the internet";
      _data['content'] = "Please check your internet connection";
      return _data;
    }
  }
}
