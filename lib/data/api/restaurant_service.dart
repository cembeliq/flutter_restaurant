import 'dart:convert';

import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(_baseUrl + 'list');
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantResult> detailRestaurant(String id) async {
    final response = await http.get(_baseUrl + 'detail/' + id);

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail data');
    }
  }

  Future<RestaurantResult> searchRestaurant(query) async {
    final response = await http.get(_baseUrl + 'search?q=' + query);

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search data');
    }
  }

}
