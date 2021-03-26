import 'package:dicoding_restaurant_app/provider/connectivity_provider.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  final String query;
  AppBarWidget({Key key, @required this.query}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

}

class _AppBarWidgetState extends State<AppBarWidget> {
  final TextEditingController _filter = TextEditingController();
  Widget _appBarSearchTitle;

  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.black26,
  );

  String _searchText = '';

  _AppBarWidgetState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          Provider.of<RestaurantProvider>(context, listen: false).getRestaurants();
          Provider.of<ConnectivityProvider>(context, listen: false).getConnectivity();

        });
      } else {
        setState(() {
          _searchText = _filter.text;
          Provider.of<RestaurantProvider>(context, listen: false).getRestaurantsByQuery(_searchText);
          Provider.of<ConnectivityProvider>(context, listen: false).getConnectivity();
        });
      }
    });
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this._searchIcon.icon != Icons.search) {
      this._appBarSearchTitle = TextField(
        controller: _filter,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search...',
        ),
      );
    } else {
      this._appBarSearchTitle = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Restaurant',
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            'Recommendation restaurant for you',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      );
    }
    return AppBar(
      toolbarHeight: 100,
      title: _appBarSearchTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
          color: Colors.black26,
        );
        this._appBarSearchTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
          ),
        );
      } else {
        this._searchIcon = Icon(
          Icons.search,
          color: Colors.black26,
        );
        this._appBarSearchTitle = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Recommendation restaurant for you',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        );
        _filter.clear();
      }
    });
  }
}
