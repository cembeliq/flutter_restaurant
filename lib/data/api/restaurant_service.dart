import 'dart:convert';

import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static final String _baseUrl = 'restaurant-api.dicoding.dev';

  Future<RestaurantResult> listRestaurant() async {
    var url = Uri.https(_baseUrl, '/list');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantResult> detailRestaurant(String id) async {
    var url = Uri.https(_baseUrl, '/detail/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail data');
    }
  }

  Future<RestaurantResult> searchRestaurant(query) async {
    var url = Uri.https(_baseUrl, '/search', {'q': '$query'});
    final response = await http.get(url);
    // final response = await http.get(_baseUrl + 'search?q=' + query);

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search data');
    }
  }
}
