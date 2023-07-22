import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/request_controller.dart';
import 'package:jayak/helper/loading.dart';
import 'package:jayak/view/request_loading_screen.dart';
import 'package:provider/provider.dart';

class RequestBottomSheet extends StatelessWidget {
  const RequestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    RequestController controller = Provider.of<RequestController>(context);
    return Container(
      height: 415,
      decoration: BoxDecoration(
        color: controller.price == null ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        // color: Colors.white,
      ),
      child: controller.price == null
          ? ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
              child: Loading())
          : Column(
              children: [
                Container(
                  height: 10,
                ),
                Container(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      BottomSheetRequestWidget(
                        price: controller.price!.save_price.toString(),
                        name: 'تكسي توفير',
                        index: 1,
                      ),
                      Container(
                        height: 5,
                      ),
                      BottomSheetRequestWidget(
                        price: controller.price!.classic_price.toString(),
                        name: 'تكسي كلاسك',
                        index: 2,
                        // selected: true,
                      ),
                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.51,
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
                                  // Container(width: 10,),
                                  SvgPicture.asset(
                                    'assets/svgs/discount.svg',
                                    color: Color(0xffFF4100),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
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
                                    'تأكيد',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<RequestController>(context, listen: false)
                              .sendRequest();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => RequestLoadingScreen(),
                          ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.97,
                          decoration: BoxDecoration(
                              color: Color(0xffFF4100),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'طلب تكسي الان',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class BottomSheetRequestWidget extends StatelessWidget {
  BottomSheetRequestWidget(
      {required this.name,
      required this.price,
      super.key,
      required this.index});
  final String price;
  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    int? selectedPrice = Provider.of<RequestController>(context).selectedPrice;
    return Container(
      // constraints: BoxConstraints(minHeight: 140, maxHeight: 180),
      child: GestureDetector(
        onTap: () {
          Provider.of<RequestController>(context, listen: false)
              .changeSelectedPrice(index);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: index != selectedPrice
                  ? null
                  : Border.all(color: Color(0xffFF4100)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2)),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'السعر التقريبي',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'سريع',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/svgs/request_car.svg',
                width: 100,
                fit: BoxFit.fitWidth,
              )
            ],
          ),
        ),
      ),
    );
  }
}
