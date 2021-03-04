import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  dynamic rating;
  Menus menus;

  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    return Restaurant(
      id: parsedJson['id'],
      name: parsedJson['name'],
      description: parsedJson['description'],
      pictureId: parsedJson['pictureId'],
      city: parsedJson['city'],
      rating: parsedJson['rating'],
      menus: Menus.fromJson(parsedJson['menus']),
    );
  }

  List<Restaurant> parseRestaurants(String json) {
    if (json == null) {
      return [];
    }
    final List parsed = jsonDecode(json)['restaurants'];
    return parsed.map((json) => Restaurant.fromJson(json)).toList();
  }
}

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    var listFoods = json['foods'] as List;
    List<Foods> foodsList = listFoods.map((i) => Foods.fromJson(i)).toList();

    var listDrinks = json['drinks'] as List;
    List<Drinks> drinksList =
        listDrinks.map((i) => Drinks.fromJson(i)).toList();
    return Menus(foods: foodsList, drinks: drinksList);
  }
}

class Foods {
  String name;

  Foods({this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(name: json['name']);
  }
}

class Drinks {
  String name;

  Drinks({this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(name: json['name']);
  }
}
