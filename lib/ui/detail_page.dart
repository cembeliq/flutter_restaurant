import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final Restaurant restaurant;

  const DetailPage({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.fitWidth,
                ),
                title: Text(restaurant.name),
                titlePadding: EdgeInsets.only(left: 50, bottom: 16),
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
                Hero(
                  tag: restaurant.name,
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
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
                      style: Theme.of(context).textTheme.subtitle1,
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
                          itemCount: restaurant.menus.foods.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Flexible(flex:1, child: Icon(Icons.food_bank)),
                                Flexible(flex:1,
                                  child: SizedBox(
                                    height: 8,
                                  ),
                                ),
                                Flexible(flex:2, child: Text(restaurant.menus.foods[index].name)),
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
                          itemCount: restaurant.menus.drinks.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Flexible(flex:1, child: Icon(Icons.local_drink)),
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 8,
                                  ),
                                ),
                                Flexible(flex: 1, child: Text(restaurant.menus.drinks[index].name)),
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
      ),
    );
  }
}
