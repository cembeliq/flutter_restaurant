import 'package:dicoding_restaurant_app/data/db/database_helper.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/utils/restaurant_state.dart';
import 'package:flutter/widgets.dart';


class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}) {
    _getBookmarks();
  }


  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();

    if (_bookmarks.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }

    notifyListeners();
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getBookmarks();
    } catch(e){
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarkRestaurant = await databaseHelper.getBookmarkById(id);
    return bookmarkRestaurant.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await databaseHelper.removeBookmark(id);
      _getBookmarks();
    } catch(e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}