import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/layout/food_layout.dart';
import 'package:jayak/model/meal.dart';
import 'package:http/http.dart' as http;
import 'package:jayak/utils/constant.dart';

import '../location_service.dart';
import '../model/food_filter.dart';

class FoodController extends ChangeNotifier {
  int navIndex = 0;
  int favorateIndex = 0;
  String? token;
  LatLng? userLocation;
  int selectedPlace = 0;
  List<Map> places = [];
  List _layouts(BuildContext context) {
    return [
      homeLayout(context),
      resturantsLayout(context),
      SliverChildListDelegate([]),
      favorateLayout(context),
      discountLayout(context)
    ];
  }

  currentLayout(BuildContext context) {
    return _layouts(context)[navIndex];
  }

  int? selected;
  List<FoodFilter> foodFilters = [
    FoodFilter(id: 1, image: 'assets/svgs/burger.svg', name: 'burger'),
    FoodFilter(id: 2, image: 'assets/svgs/breakfast.svg', name: 'breakfast'),
  ];
  List<Meal> meals = [];

  void changeSelected(int id) {
    if (selected == id) {
      selected = null;
    } else {
      selected = id;
    }
    notifyListeners();
  }

  void changeIsLiked(Meal meal) {
    meal.changeIsLiked();
    notifyListeners();
  }

  changeNavIndex(int value) {
    navIndex = value;
    notifyListeners();
  }

  changeFavorateIndex(int value) {
    favorateIndex = value;
    notifyListeners();
  }

  void setToken(String? to) {
    token = to;
    notifyListeners();
  }

  Future<http.Response> getMostSaleFood() async {
    print(token);
    return http.get(Uri.parse(mostSaleFoodUrl),
        headers: {"Authorization": 'Bearer ${token.toString()}'});
  }

  Future<http.Response> getNearRestaurants() async {
    return http.get(Uri.parse(nearResturantUrl(await _getUserLocation())),
        headers: {"Authorization": 'Bearer ${token.toString()}'});
  }

  Future<LatLng> _getUserLocation() async {
    final value = await LocationService.determinePosition();
    userLocation = LatLng(value.latitude, value.longitude);
    notifyListeners();
    return LatLng(value.latitude, value.longitude);
  }

  Future<http.Response> getCategoryList() {
    return http.get(Uri.parse(categoryListUrl), headers: {
      "Authorization": 'Bearer ${token.toString()}',
      "Accept": "application/json"
    });
  }

  Future<void> getPlaceList() async {
    http.Response _res = await http.get(Uri.parse(placeListUrl), headers: {
      "Authorization": 'Bearer ${token.toString()}',

    });
       print('places');
           print(_res.body);
    if (_res.statusCode == 200) {
   
  
      Map json = jsonDecode(_res.body);
      if (json['status']) {
        places = json['data'];
        notifyListeners();
      }
    }
  }

}
