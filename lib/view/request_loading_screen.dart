import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:jayak/controller/request_controller.dart';
import 'package:jayak/view/wait_driver_screen.dart';
import 'package:provider/provider.dart';

class RequestLoadingScreen extends StatefulWidget {
  const RequestLoadingScreen({super.key});

  @override
  State<RequestLoadingScreen> createState() => _RequestLoadingScreenState();
}

class _RequestLoadingScreenState extends State<RequestLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset('assets/gifs/request.gif')],
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
                      Provider.of<RequestController>(context, listen: false)
                          .cancelRequest();
                      Navigator.of(context).pop(true);
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
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          decoration: BoxDecoration(
            color: Color(0xffFF4100),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
              child: Text(
            'الغاء الرحلة',
            style: TextStyle(fontSize: 26, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
