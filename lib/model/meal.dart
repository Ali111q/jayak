import 'package:jayak/model/restaurant.dart';

class Meal {
  final int id;
  final String name;
  final int ratign;
  final String image;
  final int price;
  // final String stringPrice;
  bool isLiked;
  final String minTime;
  final String maxTime;
  final int discount;
   Restaurant? restaurant; 

  Meal(
      {required this.id,
      required this.name,
      required this.ratign,
      required this.price,
      // required this.stringPrice,
      required this.isLiked,
      required this.image,
      required this.minTime,
      required this.maxTime,
      required this.discount,  this.restaurant});

  factory Meal.fromJson(Map json) {
    return Meal(
        id: json['id'],
        name: json['name'],
        ratign: json['rating_sum'],
        price: json['price'],

        isLiked: json['is_favorite'],
        minTime: json['min_time'],
        image: json['image'],
        maxTime: json['max_time'],
        discount: json['discount'], restaurant:json['restaurant']==null?null: Restaurant.fromJson(json['restaurant']));
  }
  void changeIsLiked() {
    isLiked = !isLiked;
  }
}
