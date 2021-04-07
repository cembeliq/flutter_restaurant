import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app/common/navigation.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:dicoding_restaurant_app/main.dart';
import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:dicoding_restaurant_app/widget/custom_button.dart';
import 'package:flutter/material.dart';


class CardRestaurant extends StatefulWidget {
  final Restaurant restaurant;
  final RestaurantResult restaurantResult;
  // final Function onPressed;

  const CardRestaurant({Key key, @required this.restaurant, @required this.restaurantResult}) : super(key: key);

  @override
  _CardRestaurantState createState() => _CardRestaurantState();
}

class _CardRestaurantState extends State<CardRestaurant> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  final String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject2(
        context,
        DetailPage.routeName);
    // _notificationHelper.configureDidReceiveLocalNotificationSubject(
    //     context, DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    // didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CustomButton(
        //   text: 'Show plain notification with payload',
        //   onPressed: () async {
        //     await _notificationHelper
        //         .showNotification2(flutterLocalNotificationsPlugin);
        //   },
        // ),

        ListTile(
          isThreeLine: true,
          onTap: () async {
            Navigation.intentWithData(DetailPage.routeName, widget.restaurant.id);
            await _notificationHelper
                .showNotification2(flutterLocalNotificationsPlugin, widget.restaurant);
            },
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: Hero(
            tag: widget.restaurant.name,
            child: Container(
              width: 100,
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: imageUrl + widget.restaurant.pictureId,
                placeholder: (context, url) =>  Center(child: new CircularProgressIndicator()),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          title: Text(widget.restaurant.name),
          subtitle: Stack(
            children: [
              Text(widget.restaurant.city),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.orangeAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Text(widget.restaurant.rating.toString()),
              )
            ],
          ),
        ),
        Divider(
          height: 2.0,
        ),
      ],
    );
  }
}
