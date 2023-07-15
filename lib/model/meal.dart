class Meal {
  final int id;
  final String name;
  final int ratign;
  final  String image;
  final int price;
  final String stringPrice;
  bool isLiked;
  final String time;

  Meal(
      {required this.id,
      required this.name,
      required this.ratign,
      required this.price,
      required this.stringPrice,
      required this.isLiked,
      required this.image,
      required this.time});

  factory Meal.fromJson(Map json) {
    return Meal(
        id: json['id'],
        name: json['name'],
        ratign: json['ratign'],
        price: json['price'],
        stringPrice: json['stringPrice'],
        isLiked: json['isLiked'],
        time: json['time'], image: json['image']);
  }
void changeIsLiked(){
  isLiked = !isLiked;
}
}
