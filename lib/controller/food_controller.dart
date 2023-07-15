import 'package:flutter/material.dart';
import 'package:jayak/layout/food_layout.dart';
import 'package:jayak/model/meal.dart';

import '../model/food_filter.dart';

class FoodController extends ChangeNotifier {
  int navIndex = 0;
  int favorateIndex = 0;
  List _layouts(BuildContext context) {
    return [
      homeLayout(context),
      resturantsLayout(context),
      SliverChildListDelegate([]),
      favorateLayout(context),
      discountLayout(context)
    ];
  }
 currentLayout (BuildContext context){
  return _layouts(context)[navIndex];
} 
  int? selected;
  List<FoodFilter> foodFilters = [
    FoodFilter(id: 1, image: 'assets/svgs/burger.svg', name: 'burger'),
    FoodFilter(id: 2, image: 'assets/svgs/breakfast.svg', name: 'breakfast'),
  ];
  List<Meal> meals = [
    Meal(
        id: 1,
        name: 'burger',
        ratign: 2,
        price: 5000,
        stringPrice: '5,000',
        isLiked: false,
        time: '10m - 20m',
        image: 'assets/test_images/food_slider.png'),
    Meal(
        id: 2,
        name: 'pizza',
        ratign: 4,
        price: 10000,
        stringPrice: '10,000',
        isLiked: true,
        time: '15m - 25m',
        image: 'assets/test_images/food_slider.png')
  ];

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
}
