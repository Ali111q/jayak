class Restaurant {
  final int id;
  final String name;
  final String? logo;
  final String? identity;
  final bool? liked;
  final int? rating;
  final int? discount;

  Restaurant({
    required this.id,
    required this.name,
     this.logo,
     this.identity,
    this.liked,
     this.rating,
     required this.discount
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'] as String,
      logo: json['logo'],
      identity: json['identity'] ,
      liked: json['is_favorite']==1,
      rating: json['ratting'],
      discount: json['discount']
    );
  }
}
