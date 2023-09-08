import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:provider/provider.dart';

import 'order_loading_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: PopWidget(),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/svgs/jayak.svg',
            width: 70,
          ),
        ),
        actions: [HomeButtonWidget()],
      ),
      body: FutureBuilder(
          future: Provider.of<FoodController>(context).checkout(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    CheckoutWidget(
                      name: 'الوجبة',
                      qua: 'العدد',
                      price: 'السعر',
                    ),
                    ...snapshot.data!['foods'].map((e)=> CheckoutWidget(
                      name: e['name'],
                      qua: e['quantity'].toString(),
                      price: e['price'].toString(),
                    ),)
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.26,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFBFCFF),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!['delivery_price'].toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 2))
                                              ]),
                                        ),
                                        Text(
                                          ':سعر التوصيل',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 2))
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!['total_price_after_discount'].toString(),
                                          style: TextStyle(
                                              color: Color(0xffFF4100),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
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
                                                    color: Colors.black
                                                        .withOpacity(0.1),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFF4100),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!['total_price_after_discount'].toString(),
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
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => OrderLoadingScreen(),
                              ));
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
                    ),
                    Container(
                      height: 20,
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }
}

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({
    super.key,
    required this.name,
    required this.qua,
    required this.price,
  });
  final String name;
  final String qua;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            child: Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            qua,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            price,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
