import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/model/restaurant.dart';
import 'package:jayak/view/resturant_screen.dart';
import 'package:jayak/view/widgets/food_home_widgets/food_slider.dart';
import 'package:jayak/view/widgets/stars.dart';
import 'package:provider/provider.dart';

import '../../../location_service.dart';
import '../food_resturants_widgets/resturant_slider.dart';

class ResturantList extends StatelessWidget {
  const ResturantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ]),
      child: FutureBuilder(
          future: Provider.of<FoodController>(context, listen: false)
              .getNearRestaurants(),
          builder: (context, snapshot) {
            List<Restaurant>? restaurants;
            if (snapshot.hasData) {
              restaurants = [
                ...jsonDecode(snapshot.data!.body)['data']['data'].map((e) {
                  return Restaurant.fromJson(e);
                })
              ];
            }
            return Column(
              children: [
                if (snapshot.connectionState == ConnectionState.done&&restaurants != null )
                  ...restaurants!.map((e) => ResturantWidget(
                        restaurant: e,
                      ))else if(restaurants == null && snapshot.connectionState == ConnectionState.done) Container(
                        height: MediaQuery.of(context).size.height*0.7,
                        child: Center(child: Text('لا توجد مطاعم'),)
                      )else Container(
                        height: MediaQuery.of(context).size.height*0.7,
                        child: Center(child: CircularProgressIndicator(),))
              ],
            );
          }),
    );
  }
}

class ResturantWidgetFavorateWidget extends StatelessWidget {
  const ResturantWidgetFavorateWidget({required this.restaurant, super.key});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResturantScreen(id: 1,),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FoodAvatar(
                  isDiscount: restaurant.discount!=0,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 180,
                    child: Text(
                      restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xffFF4100),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Stars(restaurant.rating??0),
              Container(
                height: 20,
              ),
              FavorateWidget(restaurant.liked??false)
            ],
          )
        ]),
      ),
    );
  }
}

class FoodAvatar extends StatelessWidget {
  FoodAvatar({
    this.isDiscount = false,
    this.url,
    super.key,
  });
  bool isDiscount;
 final String? url;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFF4100)),
              shape: BoxShape.circle),
          child: url!=null? CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
             url!,
            ),
          ): CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/test_images/food_slider.png',
            ),
          ),
        ),
        if (isDiscount)
          Positioned(
              top: -1,
              child: SvgPicture.asset(
                'assets/svgs/discount.svg',
                width: 25,
              ))
      ],
    );
  }
}

class ResturantWidget extends StatelessWidget {
  const ResturantWidget({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResturantScreen(id: restaurant.id,),
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          // color: Colors.black,
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.58,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        offset: Offset(0, 1),
                        blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://media.istockphoto.com/id/1457889029/photo/group-of-food-with-high-content-of-dietary-fiber-arranged-side-by-side.jpg?b=1&s=612x612&w=0&k=20&c=BON5S0uDJeCe66N9klUEw5xKSGVnFhcL8stPLczQd_8='),
                      fit: BoxFit.fitWidth)),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.072,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.17,
                height: MediaQuery.of(context).size.width * 0.17,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          offset: Offset(0, 1),
                          blurRadius: 3)
                    ],
                    image: DecorationImage(
                        image:  NetworkImage(restaurant.logo!),
                        fit: BoxFit.fitHeight)),
              ),
            ),
            Positioned(
                bottom: 0,
                left: (MediaQuery.of(context).size.width * 0.20) + 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.21,
                      width: (MediaQuery.of(context).size.width * 0.7) - 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stars(
                                  restaurant.rating??0,
                                  width: 17,
                                ),
                                Column(crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Text(
                                        restaurant.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                      Container(alignment: Alignment.centerRight,
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: Text(
                                        restaurant.identity!,
                                        
                                        style: const TextStyle(
                                            fontSize:15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w300),
                                                                          ),
                                      ),
                                  ],
                                )
                              ]),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
