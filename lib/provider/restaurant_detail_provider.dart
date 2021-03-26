import 'package:dicoding_restaurant_app/data/api/restaurant_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:dicoding_restaurant_app/provider/enum.dart';
import 'package:flutter/foundation.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantService restaurantService;
  final String id;

  RestaurantDetailProvider({@required this.restaurantService, @required this.id}) {
    _fetchRestaurantDetail(id);
  }

  RestaurantResult _restaurantResult;
  String _message = '';
  ResultState _state;


  String get message => _message;
  RestaurantResult get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String query) async {
    print('Query in provider: ' + query);
    try{
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await restaurantService.detailRestaurant(query);
      if (restaurant.restaurant.id == null) {
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