import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app/common/navigation.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key key, @required this.restaurant}) : super(key: key);

  final String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          isThreeLine: true,
          onTap: () async {
            Navigation.intentWithData(DetailPage.routeName, restaurant.id);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: Hero(
            tag: restaurant.name,
            child: Container(
              width: 100,
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: imageUrl + restaurant.pictureId,
                placeholder: (context, url) =>
                    Center(child: new CircularProgressIndicator()),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          title: Text(restaurant.name),
          subtitle: Stack(
            children: [
              Text(restaurant.city),
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
                child: Text(restaurant.rating.toString()),
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
