import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/view/widgets/food_home_widgets/food_slider.dart';
import 'package:jayak/view/widgets/food_home_widgets/resturant_list.dart';
import 'package:jayak/view/widgets/food_resturants_widgets/resturant_slider.dart';
import 'package:jayak/view/widgets/stars.dart';

class ChartMealWidget extends StatefulWidget {
  const ChartMealWidget({super.key});

  @override
  State<ChartMealWidget> createState() => _ChartMealWidgetState();
}

class _ChartMealWidgetState extends State<ChartMealWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width * 0.55,

            height: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          Container(
    

            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.05), blurRadius: 10
              )], borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xffFF4100),
                ),
                Text(
                  'Big Burger Queso',
                  style: TextStyle(
                      color: Color(0xff153E73),
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: MediaQuery.of(context).size.width*0.1,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi, atque eaque eius esse et harum inventore ipsam  nam necessitatibus nemo pariatur provident.',
                    textAlign: TextAlign.center,
                    
                    style: TextStyle(
                        color: Color(0xff66667E),
                        fontSize: 9,
                        fontWeight: FontWeight.w300),
                  ),
                ),
               
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                        Text('4'),
                        Container(
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
                      ],
                    ),
                  ),
                ),
                Text('\$20', style: TextStyle(color: Color(0xff20D0C4), fontSize: 20, fontWeight: FontWeight.w600),)
              ],
            ),
          ),
    
     Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xffFF1141),
                    radius: 16,
                    child: SvgPicture.asset('assets/svgs/remove.svg'),
                  ),
                ),
        ],
      ),
    );
  }
}

