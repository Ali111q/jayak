import 'package:flutter/material.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:provider/provider.dart';

class FoodFilter{
  int id;
  String image;
  String name;
  FoodFilter({required this.id, required this.image, required this.name});

  factory FoodFilter.fromJson(Map json){
    return FoodFilter(id: json['id'], image: json['image'], name: json['name']);
  }

 bool isSelcted (BuildContext context){
  int? selected = Provider.of<FoodController>(context).selected;

  if (selected == id) {
    return true;
  }
  return false;
 }
 void setSelcted(BuildContext context){
    Provider.of<FoodController>(context, listen: false).changeSelected(id);

 }
}