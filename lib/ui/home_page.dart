import 'dart:io';

import 'package:dicoding_restaurant_app/ui/bookmarks_page.dart';
import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:dicoding_restaurant_app/ui/settings_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/utils/background_service.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:dicoding_restaurant_app/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  static const String _restaurantText = 'Restaurant';
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject2(context,
        DetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.collections : Icons.collections_rounded),
      label: _restaurantText,
    ),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.bookmark : Icons.collections_bookmark),
      label: BookmarksPage.bookmarksTitle
    ),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        label: SettingsPage.settingsTitle
    )
  ];

  List<Widget> _listWidget = [
    RestaurantListPage(),
    BookmarksPage(),
    SettingsPage(),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavigationBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavigationBarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

}