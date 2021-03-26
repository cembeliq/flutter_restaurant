
import 'package:dicoding_restaurant_app/provider/enum.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/ui/card_restaurant.dart';
import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            if (state.result.founded == 0) {
              return Center(child: Text('Data tidak ditemukan'),);
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurant(
                      restaurant: restaurant,
                      onPressed: () {
                        Navigator.pushNamed(context, DetailPage.routeName,
                            arguments: restaurant.id.toString());
                      },
                    );
                  }
              );
            }
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message),);
          } else if (state.state == ResultState.Error) {
            return Center(child: Text(state.message),);
          } else {
            return Center(child: Text(''),);
          }
        }
    );
  }
}
