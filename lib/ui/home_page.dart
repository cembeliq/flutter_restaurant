import 'package:dicoding_restaurant_app/ui/detail_page.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final restaurant = Restaurant();
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List names = [];
  List filteredNames = [];

  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.black26,
  );
  Widget _appBarSearchTitle;

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
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
  void initState() {
    super.initState();
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

  Widget _appBar(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    List tempList = [];
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants =
            restaurant.parseRestaurants(snapshot.data);
        if (_filter.text.isNotEmpty) {
          restaurants.forEach((element) {
            if (element.name
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
              tempList.add(element);
            }
          });
          filteredNames = tempList;
        } else {
          filteredNames = restaurants;
        }

        return ListView.builder(
          itemCount: filteredNames.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, index);
          },
        );
      },
    );
  }

  Column _buildRestaurantItem(BuildContext context, int index) {
    return Column(
      children: [
        ListTile(
          isThreeLine: true,
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: filteredNames[index]);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          leading: Hero(
            tag: filteredNames[index].name,
            child: Container(
              width: 100,
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: filteredNames[index].pictureId,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          title: Text(filteredNames[index].name),
          subtitle: Stack(
            children: [
              Text(filteredNames[index].city),
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
                child: Text(filteredNames[index].rating.toString()),
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
