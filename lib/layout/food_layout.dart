import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/model/restaurant.dart';
import 'package:jayak/model/search.dart';
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
    FoodSearch(
      searchType: SearchType.restaurant,
    ),
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
    Container(
      height: 70,
    )
  ]);
}

SliverChildListDelegate resturantsLayout(BuildContext context) {
  Words _words = Provider.of<LanguageController>(context).words;

  return SliverChildListDelegate([
    FoodSearch(
      hint: _words.resturantSearchHint(),
      searchType: SearchType.restaurant,
    ),
    ResturantSlider(),
    Container(
      height: 70,
    )
  ]);
}

SliverChildListDelegate favorateLayout(BuildContext context) {
  Words _words = Provider.of<LanguageController>(context).words;

  return SliverChildListDelegate([
 
    FavorateTabBar(),
    favorateSlider(),
    Container(
      height: 70,
    )
  ]);
}

SliverList discountLayout(BuildContext context) {
  return SliverList(
    
    delegate: SliverChildListDelegate([
      Container(
        height: MediaQuery.of(context).size.height*0.8,
        child: FutureBuilder(
          future: Provider.of<FoodController>(context).geiDiscounted(),
          builder: (context, snapshot) {
           if (snapshot.hasError) {
                    return Text('حصل خطأ ما');
                  }
                  if (snapshot.data ==null|| snapshot.connectionState== ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List _list = jsonDecode(snapshot.data!.body)['data']['data'].map((e)=>Restaurant.fromJson(e)).toList();
        return  GridView.builder(
          itemCount: _list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.7),
            itemBuilder: (context, index) => DiscountWidget(restaurant: _list[index],),
          );
          } 
        ),
      )
    ]),
  );
}
