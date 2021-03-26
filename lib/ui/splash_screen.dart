import 'dart:async';
import 'dart:math';

import 'package:dicoding_restaurant_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _size = 100.0;

  Tween _animationTween = Tween<double>(begin: 0, end: pi * 2);

  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: _animationTween,
            duration: Duration(seconds: 5),
            builder: (context, double value, child) {
              return Transform.rotate(
                angle: value,
                child: Container(
                  child: Image.asset('assets/default_restaurant.png'),
                  height: _size,
                  width: _size,
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
