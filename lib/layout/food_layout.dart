import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/view/widgets/food_discount_widgets/discount_widget.dart';
import 'package:jayak/view/widgets/food_favorate_widgets/favorate_slider.dart';
import 'package:jayak/view/widgets/food_resturants_widgets/resturant_slider.dart';
import 'package:provider/provider.dart';

import '../controller/language_controller.dart';
import '../utils/words.dart';
import '../view/widgets/food_favorate_widgets/favorate_tabBar.dart';
import '../view/widgets/food_home_widgets/food_filter.dart';
import '../view/widgets/food_home_widgets/food_search.dart';
import '../view/widgets/food_home_widgets/food_slider.dart';
import '../view/widgets/food_home_widgets/resturant_list.dart';

SliverChildListDelegate homeLayout(BuildContext context) {
  Words _words = Provider.of<LanguageController>(context).words;

  return SliverChildListDelegate([
    FoodSearch(),
    FoodFilterSlider(),
    FoodSlider(),
    Align(
      alignment: _words.language == 'ar'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _words.nearbyResturants(),
          style: TextStyle(fontSize: 22),
        ),
      ),
    ),
    ResturantList(),
    Container(height: 70,)
  ]);
}

SliverChildListDelegate resturantsLayout(BuildContext context) {
  Words _words = Provider.of<LanguageController>(context).words;

  return SliverChildListDelegate([
    FoodSearch(
      hint: _words.resturantSearchHint(),
    ),
    ResturantSlider(),
    Container(height: 70,)

  ]);
}

SliverChildListDelegate favorateLayout(BuildContext context) {
  Words _words = Provider.of<LanguageController>(context).words;


  return SliverChildListDelegate([
    FoodSearch(
      hint: _words.favorateSearchHint(),
    ),
  FavorateTabBar(),
  favorateSlider(),
    Container(height: 70,)

  ]);
}


SliverGrid discountLayout(BuildContext context) {
  return SliverGrid.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7), itemBuilder:(context, index) => DiscountWidget(),) ;
}
