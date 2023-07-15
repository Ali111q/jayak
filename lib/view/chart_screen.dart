import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak/view/order_loading_screen.dart';
import 'package:jayak/view/widgets/chart_widgets/chart_meal_widget.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:provider/provider.dart';

import '../controller/language_controller.dart';
import '../utils/words.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    Words _words = Provider.of<LanguageController>(context).words;

    return Scaffold(
        body: Stack(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          leading: PopWidget(),
          toolbarHeight: 60,
          title: Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/svgs/jayak.svg',
              width: 70,
              color: Colors.black,
            ),
          ),
          actions: [HomeButtonWidget()],
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.87,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Color(0xffFF4100),
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/resturant.svg',
                                color: Colors.white,
                              ),
                              Text(
                                'Ghost',
                                style: TextStyle(color: Colors.white),
                              ),
                              Container()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE2EDF2)),
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/resturant.svg',
                                color: Color(0xffFF4100),
                              ),
                              Text(
                                'Ghost',
                                style: TextStyle(
                                  color: Color(0xffFF4100),
                                ),
                              ),
                              Container()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        ChartMealWidget(),
                        ChartMealWidget(),
                        ChartMealWidget(),
                        ChartMealWidget(),
                      ]),
                    ),
                  ),
        AdsSwiper(),
               
                ],
              ),
            ),
          ),
        ),

        Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.31,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFBFCFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '7,000',
                                  style: TextStyle(
                                      color: Color(0xff153E73),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2))
                                      ]),
                                ),
                                Text(
                                  ':التوصيل',
                                  style: TextStyle(
                                      color: Color(0xff153E73),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2))
                                      ]),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '7,000',
                                  style: TextStyle(
                                      color: Color(0xff153E73),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2))
                                      ]),
                                ),
                                Text(
                                  ':وقت الطلب',
                                  style: TextStyle(
                                      color: Color(0xff153E73),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2))
                                      ]),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '7,000',
                                  style: TextStyle(
                                      color: Color(0xffFF4100),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2))
                                      ]),
                                ),
                                Text(
                                  ':سعر الطلب',
                                  style: TextStyle(
                                      color: Color(0xffFF4100),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2))
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.49,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffFF4100),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 12),
                            child: Row(
                              children: [
                                Text(
                                  'كود التخفيض',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  'assets/svgs/discount.svg',
                                  color: Color(0xffFF4100),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                              color: Color(0xffFF4100),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '5,500 IQD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => OrderLoadingScreen(),) );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                          color: Color(0xffFF4100),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تآكيد',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    ));
  }
}

class AdsSwiper extends StatefulWidget {
  const AdsSwiper({super.key});

  @override
  State<AdsSwiper> createState() => _AdsSwiperState();
}

class _AdsSwiperState extends State<AdsSwiper> {
  @override
  Widget build(BuildContext context) {
    return Container(
              height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.95,
      child: ClipRRect(
    borderRadius: BorderRadius.circular(20)
,
        child: Swiper(itemCount: 2, itemBuilder: (context, index) => Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                        color: Colors.black,
          borderRadius: BorderRadius.circular(20)
          ,image:DecorationImage(image: AssetImage('assets/test_images/food_slider.png'), fit: BoxFit.fitWidth)  
                         ),
                      ),),
      ),
    );
  }
}


