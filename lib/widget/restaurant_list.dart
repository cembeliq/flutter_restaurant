import 'package:dicoding_restaurant_app/data/api/restaurant_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:dicoding_restaurant_app/provider/connection_state.dart';
import 'package:dicoding_restaurant_app/provider/connectivity_provider.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_state.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/ui/card_restaurant.dart';
import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:dicoding_restaurant_app/widget/check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantProvider, ConnectivityProvider>(
        builder: (context, state, state2, _) {
      if (state2.state == ConnectivityState.Connected) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          if (state.result.founded == 0) {
            return Center(
              child: Text('Data tidak ditemukan'),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView.builder(
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
                  }),
            );
          }
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        }
        else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        }
        else {
          return Center(
            child: Text(''),
          );
        }
      } else {
        return CheckConnectivity();
      }
    });
  }

  Future<RestaurantResult> _handleRefresh() async {
    return await RestaurantProvider(restaurantService: RestaurantService()).fetchAllRestaurant();
  }
}
