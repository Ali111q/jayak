import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:provider/provider.dart';

class OrderLoadingScreen extends StatefulWidget {
  const OrderLoadingScreen({super.key});

  @override
  State<OrderLoadingScreen> createState() => _OrderLoadingScreenState();
}

class _OrderLoadingScreenState extends State<OrderLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FoodController>(context, listen: false).socketConnect();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/gifs/request.gif'),
            Container(
        width: MediaQuery.of(context).size.width*0.4,

              child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  OrderStateWidget('موافقة السائق', done: true,),
                  OrderStateWidget('موافقة المطعم', done: true,),
                  OrderStateWidget('السائق في المطعم', done: true,),
                  OrderStateWidget('الطلب في الطريق', done: true,),
                ],
              ),
            ),
      
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showDialog<bool?>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('الغاء الرحلة؟'),
                content: Text('هل انت متأكد من الغاء الرحلة؟'),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'لا',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: Text(
                      'نعم',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Perform the action you want here
                      Navigator.of(context).pop(true); // Close the dialog
                    },
                  ),
                ],
              );
            },
          ).then((value) {
            if (value == true) {
              Navigator.of(context).pop();
            }
          });
        },
        child: Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 40 , vertical: 25),
          decoration: BoxDecoration(
            color: Color(0xffFF4100),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
              child: Text(
            'الغاء الطلب',
            style: TextStyle(fontSize: 26, color: Colors.white),
          )),
        ),
      ),
    );
  }
}

class OrderStateWidget extends StatelessWidget {
   OrderStateWidget( this.text,{
     required this.done,
    super.key,
  });
final String text;
bool done;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text),
          Container(width: 5,),
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Color(0xffFF4100), shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
