import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/model/restaurant.dart';
import 'package:jayak/view/widgets/food_home_widgets/food_slider.dart';
import 'package:jayak/view/widgets/food_home_widgets/resturant_list.dart';
import 'package:jayak/view/widgets/stars.dart';

import '../../resturant_screen.dart';

class DiscountWidget extends StatefulWidget {
  const DiscountWidget({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  State<DiscountWidget> createState() => _DiscountWidgetState();
}

class _DiscountWidgetState extends State<DiscountWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResturantScreen(id: widget.restaurant.id,),
        ));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned(
                bottom: 10,
                left: 3,
                right: 3,
                // width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 1),
                                blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(22)),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                          ),
                          Text(
                           widget.restaurant.name,
                           overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xffFF4100),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.12),
                                      offset: Offset(0, 2))
                                ],
                                fontFamily: 'font'),
                          ),
                          Text(
                            'تبدوا مهمة اختيار العبارة المثالية لمطعمك امرا ',
                            textAlign: TextAlign.center,
                          ),
                          Container(height: 10,),
                          Stars(widget.restaurant.rating??0, width: 15,)
                        ],
                      ),
                    ),
                  ],
                )),
            Positioned(
                right: MediaQuery.of(context).size.width * 0.12,
                left: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.width * 0.41,
                child: FoodAvatar(url: widget.restaurant.logo,)),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.21,
                child: SvgPicture.asset('assets/svgs/discount.svg')),
            Positioned(
                width: MediaQuery.of(context).size.width * 0.45,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xffFF4100),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/svgs/double_arrow_back.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(),
                    FavorateWidget(widget.restaurant.liked??false),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
