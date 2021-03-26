import 'package:dicoding_restaurant_app/data/api/restaurant_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:dicoding_restaurant_app/provider/enum.dart';
import 'package:flutter/material.dart';


class RestaurantProvider extends ChangeNotifier {
  RestaurantService restaurantService;

  RestaurantProvider({ @required this.restaurantService }) {
    getRestaurants();
  }

  RestaurantResult _restaurantResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;

  void getRestaurants() {
    _doCall();
  }

  void getRestaurantsByQuery(String query) {
    _doCall(query: query);
  }

  void _doCall({String query="" }) {
    _state = ResultState.Loading;
    notifyListeners();
    Future<dynamic> result;

    if (query.isEmpty) {
      result = _fetchAllRestaurant();
    } else {
      result = _fetchRestaurant(query);
    }
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try{
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await restaurantService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch(e){
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchRestaurant(String query) async {
    print('Query in provider: ' + query);
    try{
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await restaurantService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch(e){
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}