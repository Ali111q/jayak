import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/helper/loading.dart';
import 'package:jayak/view/chart_screen.dart';
import 'package:jayak/view/widgets/food_favorate_widgets/favorate_slider.dart';

import 'package:jayak/view/widgets/food_home_widgets/food_filter.dart';
import 'package:jayak/view/widgets/food_home_widgets/food_slider.dart';
import 'package:jayak/view/widgets/food_home_widgets/resturant_list.dart';
import 'package:jayak/view/widgets/food_resturants_widgets/resturant_slider.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:provider/provider.dart';

import '../controller/food_controller.dart';

class ResturantScreen extends StatefulWidget {
  const ResturantScreen({required this.id, super.key});
  final int id;
  @override
  State<ResturantScreen> createState() => _ResturantScreenState();
}

class _ResturantScreenState extends State<ResturantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<FoodController>(context, listen: false)
              .getresturantById(widget.id),
          builder: (context, snapshot) {
            return Stack(
              children: [
                Positioned.fill(
                  child: snapshot.data == null
                      ? Container()
                      : Image.asset(
                          'assets/test_images/food_slider.png',
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fitWidth,
                        ),
                ),
                Positioned(
                    top: 34,
                    left: 20,
                    child: PopWidget(
                      onTap: Provider.of<FoodController>(context)
                            .cart
                            .foods
                            .length <=0?null: () {
                        showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('تفريغ السلة؟'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        }, child: Text('لا', style: TextStyle(color: Colors.blue),)),
                                    TextButton(
                                        onPressed: () {Provider.of<FoodController>(context, listen: false).clearCart();
                                        Navigator.of(context).pop(true);
                                        }, child: Text('نعم', style: TextStyle(color: Colors.red),)),
                                  ],
                                )).then((value) {
                                  if(value == true){
                                    Navigator.of(context).pop();
                                  }
                                });
                      },
                    )),
                snapshot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Positioned(
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(34),
                                    topRight: Radius.circular(34))),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      snapshot.data!['restaurant'].name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 39,
                                          color: Color(0xffFF4100),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...snapshot.data!['cats']
                                              .map((e) => FoodFilterWidget(
                                                    e,
                                                    clickable: false,
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                    ),
                                    if (snapshot.data!['foods'].length != 0)
                                      Text(
                                        'الاكلات الجديدة',
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ...snapshot.data!['foods'].map(
                                      (e) => FavorateMealWidget(
                                        meal: e,
                                        inFavorate: false,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                if (snapshot.data != null)
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.78,
                      right: 20,
                      child: FavorateWidget(
                        snapshot.data!['restaurant'].liked,
                        radius: 25,
                      ))
              ],
            );
          }),
      floatingActionButton:
          Provider.of<FoodController>(context).cart.foods.length <= 0
              ? null
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChartScreen(),
                    ));
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xffFF4100),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 1)
                        ]),
                    child: Stack(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/svgs/chart.svg',
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                            right: 1,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, -1),
                                        blurRadius: 1)
                                  ]),
                              child: Center(
                                  child: Text(
                                      Provider.of<FoodController>(context)
                                          .cart
                                          .foods
                                          .length
                                          .toString())),
                            ))
                      ],
                    ),
                  ),
                ),
    );
  }
}

class CommonMealWidget extends StatefulWidget {
  const CommonMealWidget({super.key});

  @override
  State<CommonMealWidget> createState() => _CommonMealWidgetState();
}

class _CommonMealWidgetState extends State<CommonMealWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width * 0.4,
      // color: Colors.black,
      margin: EdgeInsets.all(5),
      child: Stack(
        children: [
          Positioned(
              bottom: 15,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xff559E8D),
                      Color(0xff6AC5AF),
                    ]),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                    ),
                    Text(
                      'سلطة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 10,
                    ),
                    TimeWidget(
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.center,
                      minTime: "06:43",
                      maxTime: "06:43",
                    ),
                    Container(
                      height: 10,
                    ),
                    PriceWidget(
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.center,
                      price: 20,
                    )
                  ],
                ),
              )),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: FoodAvatar()),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  'assets/svgs/food_home.svg',
                  color: Color(0xffFF4100),
                ),
              ))
        ],
      ),
    );
  }
}
