import 'restaurant.dart';


class RestaurantResult {
  RestaurantResult({
    this.error,
    this.message,
    this.count,
    this.founded,
    this.restaurants,
    this.restaurant
  });

  bool error;
  String message;
  int count;
  int founded;
  List<Restaurant> restaurants;
  Restaurant restaurant;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) {
    if (json["restaurant"] != null) {
      return RestaurantResult(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        founded: json["founded"] == null ? null : json["founded"],
        restaurant: Restaurant.fromJson(json["restaurant"])
      );
    } else {
      return RestaurantResult(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        founded: json["founded"] == null ? null : json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))) == null ? null : List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "count": count == null ? null : count,
    "founded": founded == null ? null : founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())) == null ? null : List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

