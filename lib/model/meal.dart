class Meal {
  final int id;
  final String name;
  final int ratign;
  final String image;
  final int price;
  final String stringPrice;
  bool isLiked;
  final int minTime;
  final int maxTime;
  final double discount;

  Meal(
      {required this.id,
      required this.name,
      required this.ratign,
      required this.price,
      required this.stringPrice,
      required this.isLiked,
      required this.image,
      required this.minTime,
      required this.maxTime,
      required this.discount});

  factory Meal.fromJson(Map json) {
    return Meal(
        id: json['id'],
        name: json['name'],
        ratign: json['rating_sum'],
        price: json['price'],
        stringPrice: json['stringPrice'],
        isLiked: json['isLiked'],
        minTime: json['min_time'],
        image: json['image'],
        maxTime: json['max_time'],
        discount: json['discount']);
  }
  void changeIsLiked() {
    isLiked = !isLiked;
  }
}
