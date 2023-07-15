import 'dart:convert';

class RequestPrice {
  final int classic_price;
  final int save_price;

  RequestPrice({required this.classic_price, required this.save_price});
  factory RequestPrice.fromJson(Map<String, dynamic> json) {
    return RequestPrice(
        classic_price: json['classic_price'], save_price: json['save_price']);
  }
}
