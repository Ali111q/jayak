import 'package:google_maps_flutter/google_maps_flutter.dart';

class Taxi {
  final String id;
  final String name;
  final String mobile;
  final String image;
  final String? vechileType;
  final String? vechileNumber;
  final int price;
  LatLng latLng;

  Taxi(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.image,
      required this.vechileType,
      required this.price,
      this.vechileNumber,
      required this.latLng});

  factory Taxi.fromJson(Map<String, dynamic> json) => Taxi(
      id: json['order_id'],
      name: json['taxi']['name'],
      price: json['price'],
      mobile: json['taxi']['mobile'],
      image: json['taxi']['image'],
      vechileType: json['taxi']['vehicle_type'],
      latLng: LatLng(json['lat'], json['lng']));
}
