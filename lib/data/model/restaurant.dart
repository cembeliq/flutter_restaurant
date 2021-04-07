import 'package:dicoding_restaurant_app/data/model/category.dart';
import 'package:dicoding_restaurant_app/data/model/customer_review.dart';
import 'package:dicoding_restaurant_app/data/model/menu.dart';

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    if (json["categories"] == null) {
      return Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"] == null ? null : json["address"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
      );
    } else {
      return Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"] == null ? null : json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))) ??
            null,
        menus: Menus.fromJson(json["menus"]) == null
            ? null
            : Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address == null ? null : address,
        "pictureId": pictureId,
        "categories": categories != null ?
            List<dynamic>.from(categories.map((x) => x.toJson())) : null,
        "menus": menus != null ? menus.toJson() : null,
        "rating": rating,
        "customerReviews": customerReviews != null ?
            List<dynamic>.from(customerReviews.map((x) => x.toJson())) :
                null,
      };
}
