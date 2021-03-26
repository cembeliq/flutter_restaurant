import 'package:dicoding_restaurant_app/widget/app_bar.dart';
import 'package:dicoding_restaurant_app/widget/restaurant_list.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: AppBarWidget()
            ),
            body: RestaurantListWidget()
        );
  }
}