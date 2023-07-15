import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jayak/view/widgets/food_home_widgets/resturant_list.dart';
import 'package:jayak/view/widgets/stars.dart';
import 'package:provider/provider.dart';

import '../../../controller/food_controller.dart';
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
              FavorateResturantWidget(),
              FavorateResturantWidget(),
              FavorateResturantWidget(),
              FavorateResturantWidget(),
            ]
          : [
              FavorateMealWidget(),
              FavorateMealWidget(),
              FavorateMealWidget(),
              FavorateMealWidget(),
            ],
    );
  }
}

class FavorateMealWidget extends StatelessWidget {
  const FavorateMealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: FoodAvatar(isDiscount: true,)
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(),
                    Text(
                      '99 Grill',
                      style: TextStyle(
                          color: Color(0xffFF4100),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    TimeWidget(),
                    PriceWidget()
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Stars(3), FavorateWidget(true)],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FavorateResturantWidget extends StatelessWidget {
  const FavorateResturantWidget({super.key});

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
        child: ResturantWidgetFavorateWidget());
  }
}

