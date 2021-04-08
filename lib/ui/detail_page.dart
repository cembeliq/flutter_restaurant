import 'package:dicoding_restaurant_app/data/api/restaurant_service.dart';
import 'package:dicoding_restaurant_app/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:dicoding_restaurant_app/utils/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String id;

  DetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
          restaurantService: RestaurantService(), id: widget.id),
      child: Scaffold(
        body: _buildItem(context),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          var restaurant = state.result.restaurant;
          var id = restaurant.id;
          return Consumer<DatabaseProvider>(
            builder: (context, stateDb, child) {
              return FutureBuilder<bool>(
                  future: stateDb.isBookmarked(id),
                  builder: (context, snapshot) {
                    var isBookmarked = snapshot.data ?? false;
                    return NestedScrollView(
                      headerSliverBuilder: (context, isScrolled) {
                        return [
                          SliverAppBar(
                            pinned: true,
                            expandedHeight: 200,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Image.network(
                                imageUrl + restaurant.pictureId,
                                fit: BoxFit.fitWidth,
                              ),
                              title: Text(restaurant.name),
                              titlePadding:
                                  EdgeInsets.only(left: 50, bottom: 16),
                            ),
                          ),
                        ];
                      },
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Hero(
                                    tag: restaurant.name,
                                    child: Text(
                                      restaurant.name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  Container(
                                      child: isBookmarked
                                          ? IconButton(
                                              onPressed: () =>
                                                  stateDb.removeBookmark(id),
                                              icon: Icon(Icons.favorite))
                                          : IconButton(
                                              onPressed: () => stateDb
                                                  .addBookmark(restaurant),
                                              icon:
                                                  Icon(Icons.favorite_border))),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.redAccent,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                  color: Colors.black26,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Text(restaurant.description),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                  color: Colors.black26,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Menu',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Table(
                                columnWidths: {1: FractionColumnWidth(0.7)},
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Foods'),
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            restaurant.menus.foods.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  child: Icon(Icons.food_bank)),
                                              Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  height: 8,
                                                ),
                                              ),
                                              Flexible(
                                                  flex: 2,
                                                  child: Text(restaurant.menus
                                                      .foods[index].name)),
                                            ],
                                          );
                                        }),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Drinks'),
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            restaurant.menus.drinks.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  child:
                                                      Icon(Icons.local_drink)),
                                              Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  height: 8,
                                                ),
                                              ),
                                              Flexible(
                                                  flex: 1,
                                                  child: Text(restaurant.menus
                                                      .drinks[index].name)),
                                            ],
                                          );
                                        }),
                                  ])
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
