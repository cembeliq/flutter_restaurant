import 'package:dicoding_restaurant_app/provider/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../ui/home_page.dart';

class CheckConnectivity extends StatefulWidget {
  @override
  _CheckConnectivityState createState() => _CheckConnectivityState();
}

class _CheckConnectivityState extends State<CheckConnectivity> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, state, _) {
      return AlertDialog(
        title: Text(state.data['title'].toString()),
        content: Text(state.data['content'].toString()),
        actions: [
          Builder(
            builder: (context) => FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                }),
          )
        ],
      );
    });
  }
}
