import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/model/meal.dart';
import 'package:jayak/view/widgets/stars.dart';
import 'package:provider/provider.dart';

class FoodSlider extends StatelessWidget {
  const FoodSlider({super.key});

  @override
  Widget build(BuildContext context) {
    List<Meal> meals = Provider.of<FoodController>(context).meals;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...meals.map((e) => FoodSliderWidget(e))
        ],
      ),
    );
  }
}

class FoodSliderWidget extends StatelessWidget {
   FoodSliderWidget(this.meal, {super.key});
  Meal meal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      height: MediaQuery.of(context).size.width * 0.7,
      width: MediaQuery.of(context).size.width * 0.46,
      decoration: BoxDecoration(
          // color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(7)),
      child: Stack(
        children: [
          Image.asset(
            meal.image,
            width: MediaQuery.of(context).size.width * 0.46,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
              bottom: -10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.46,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.17,
                        width: MediaQuery.of(context).size.width * 0.46,
                        margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              meal.name,
                              style: TextStyle(color: Color(0xffFF4100)),
                            ),
                            Stars(meal.ratign),
                            Container(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svgs/price.svg'),
                                    Text(
                                      '5,000',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svgs/clock.svg'),
                                    Text(
                                      '10m - 20m',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      
                      child: FavorateWidget(meal.isLiked, onTap: () {
                        Provider.of<FoodController>(context, listen: false).changeIsLiked(meal);
                      },))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class FavorateWidget extends StatelessWidget {
   FavorateWidget(  this.isLiked,{
    this.onTap,
    this.radius = 15,

    super.key,
  });
  Function()? onTap;
  bool isLiked;
  double radius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Color(0xffFF4100),
        child: Center(child:Icon(isLiked?Icons.favorite: Icons.favorite_outline, color: Colors.white,size: radius+4,),),
      ),
    );
  }
}
