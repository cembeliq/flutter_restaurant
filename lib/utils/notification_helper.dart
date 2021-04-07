import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dicoding_restaurant_app/common/navigation.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';


final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;
  Random random = new Random();

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload);
        });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurantResult) async {

    int randomNumber = random.nextInt(restaurantResult.count - 1 ) + 1;
    var _channelId = "11";
    var _channelName = "channel_011";
    var _channelDescription = "dicoding list restaurant channel";

    print("=========================show notification==================");

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Daftar Restaurant Favorit</b>";
    var restaurantName = restaurantResult.restaurants[randomNumber].name;
    var payload = { "Id" : restaurantResult.restaurants[randomNumber].id};
    debugPrint("restaurant id =========== : " + json.encode(payload));
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, restaurantName, platformChannelSpecifics,
        payload: json.encode(payload));
  }

  Future<void> showNotification2(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding restaurant channel";

    print("=========================show notification==================");

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Restaurant Favorit</b>";
    var restaurantName = restaurant.name;
    var payload = { "Id" : restaurant.id};
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, restaurantName, platformChannelSpecifics,
        payload: json.encode(payload));
  }


  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
          (String payload) async {
        // var data = RestaurantResult.fromJson(json.decode(payload));
        // var restaurant = data.restaurants[0];
            var data = json.decode(payload);
        Navigation.intentWithData(route, data['Id']);
      },
    );
  }

  void configureSelectNotificationSubject2(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = json.decode(payload);
      debugPrint("+++++++++++data++++++++++ : " + data["Id"]);
      await Navigator.pushNamed(context, route,
          arguments: DetailPage(id: data["Id"]));
    });
  }
}
