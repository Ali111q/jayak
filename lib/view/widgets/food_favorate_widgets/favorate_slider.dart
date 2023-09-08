import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jayak/model/restaurant.dart';
import 'package:jayak/view/resturant_screen.dart';
import 'package:jayak/view/widgets/food_home_widgets/resturant_list.dart';
import 'package:jayak/view/widgets/stars.dart';
import 'package:provider/provider.dart';

import '../../../controller/food_controller.dart';
import '../../../model/meal.dart';
import '../food_home_widgets/food_slider.dart';
import '../food_resturants_widgets/resturant_slider.dart';

class favorateSlider extends StatelessWidget {
  const favorateSlider({super.key});

  @override
  Widget build(BuildContext context) {
    int _index = Provider.of<FoodController>(context).favorateIndex;

    return Column(
      children: _index == 0
          ? [
              FutureBuilder(
                  future:
                      Provider.of<FoodController>(context).getFavorateFood(),
                  builder: (context, snapshot) {
                    List<Meal> _favs = [];

                    if (snapshot.hasData) {
                      if (!snapshot.hasError) {
                        var json = jsonDecode(snapshot.data!.body);
                        json['data']['data'].forEach((e) {
                          _favs.add(Meal.fromJson(e));
                        });
                      }
                    } else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if (!_favs.isEmpty) {
                      return Column(children: [
                        ..._favs.map((e) => FavorateMealWidget(
                              meal: e,
                              inFavorate: true,
                            ))
                      ]);
                    } else {
                      return Container();
                    }
                  })
            ]
          : [
              FutureBuilder(
                future: Provider.of<FoodController>(context)
                    .getFavorateResturants(),
                builder: ((context, snapshot) {
                  List<Restaurant> _favs = [];

                  if (snapshot.hasData) {
                    if (!snapshot.hasError) {
                      var json = jsonDecode(snapshot.data!.body);
                      json['data']['data'].forEach((e) {
                        _favs.add(Restaurant.fromJson(e));
                      });
                    }
                  } else {
                                         return Center(child: CircularProgressIndicator(),);

                  }
                  if (!_favs.isEmpty) {
                    return Column(children: [
                      ..._favs.map((e) => FavorateResturantWidget(
                            restaurant: e,
                          ))
                    ]);
                  } else {
                    return Container();
                  }
                }),
              )
            ],
    );
  }
}

class FavorateMealWidget extends StatelessWidget {
  FavorateMealWidget({required this.inFavorate, required this.meal, super.key});
  final Meal meal;
  final bool inFavorate;
  @override
  Widget build(BuildContext context) {
    List list = Provider.of<FoodController>(context)
        .cart
        .foods
        .map((e) => e.meal.id)
        .toList();
    bool isInCart = list.contains(meal.id);
        int? mealNum;
  int? index;
    if (isInCart) {
       mealNum = Provider.of<FoodController>(context).cart.foods.where((e)=>e.meal.id == meal.id).first.num;
index = Provider.of<FoodController>(context).cart.foods.indexWhere((e)=>e.meal.id == meal.id);
    }

    return GestureDetector(
      onTap: () {
        if (!isInCart && !inFavorate) {
        Provider.of<FoodController>(context, listen: false).addFoodToCart(meal);
        }
        if (inFavorate) {
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => ResturantScreen(id: meal.restaurant!.id),));
        }
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 9),
                      color: Color(0xff4A72A8).withOpacity(0.16),
                      blurRadius: 7)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xffFF4100))),
                              child: FoodAvatar(
                                isDiscount: meal.discount != 0,
                                url: meal.image,
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(),
                          Container(
                            width: 180,
                            child: Text(
                              meal.name,
                              style: TextStyle(
                                  color: Color(0xffFF4100),
                                  fontSize: 22,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TimeWidget(
                            minTime: meal.minTime,
                            maxTime: meal.maxTime,
                          ),
                          PriceWidget(
                            price: meal.price,
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Stars(meal.ratign), FavorateWidget(meal.isLiked, onTap: (){
                        Provider.of<FoodController>(context, listen: false).addFoodToFavorate(meal.id);
                      },)],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isInCart)
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ],
                  color: Colors.white,
                  
                  ),
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:(){
                            if (mealNum ==1) {
                              Provider.of<FoodController>(context, listen: false).removeCartMeal(index!);
                            }else{

                            Provider.of<FoodController>(context, listen:false).removeCartItem(index!);
                            }
                          } ,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Color(0xffF3F3F3),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Color(0xffFF4100),
                              ),
                            ),
                          ),
                        ),
                        Text(mealNum.toString()),
                        GestureDetector(
                          onTap: () {
                            Provider.of<FoodController>(context, listen:false).addCartItem(index!);
                          },
                          child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Color(0xffFF4100),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ))),
                        ),
                      ],
                    ),
            ),
        ],
      ),
    );
  }
}

class FavorateResturantWidget extends StatelessWidget {
  const FavorateResturantWidget({required this.restaurant, super.key});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 9),
                  color: Color(0xff4A72A8).withOpacity(0.16),
                  blurRadius: 12)
            ]),
        child: ResturantWidgetFavorateWidget(
          restaurant: restaurant,
        ));
  }
}
