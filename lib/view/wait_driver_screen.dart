import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/model/taxi.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:provider/provider.dart';

import '../controller/request_controller.dart';

class WaitDriverScreen extends StatefulWidget {
  const WaitDriverScreen({super.key});

  @override
  State<WaitDriverScreen> createState() => _WaitDriverScreenState();
}

class _WaitDriverScreenState extends State<WaitDriverScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Taxi _taxi = Provider.of<RequestController>(context).taxi;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ClipRect(
                  child: GoogleMap(
                    /// this is required parameter to pass initial position of map
                    /// todo: make this parameter = current user location
                    initialCameraPosition:
                        CameraPosition(target: LatLng(44, 33), zoom: 5),

                    /// disable zoom control buttons
                    zoomControlsEnabled: false,

                    /// Enable user location courser
                    myLocationEnabled: true,

                    /// disable go to my location button
                    /// in our case I disabled it for creating a custom button with custom ui
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    onCameraIdle: () {
                      /// when camera stop moving
                      /// set [isMoving] false to animate courser to Idle setuation
                    },
                    onMapCreated:
                        Provider.of<RequestController>(context, listen: false)
                            .initWaitMapController,
                    markers:
                        Provider.of<RequestController>(context).waitMarkers,
                    onCameraMoveStarted: () {
                      /// when camera is moving
                      /// set [isMoving] true to animate courser to moving setuation
                    },

                    /// setting [GoogleMapContoller]
                    // onMapCreated: (controller) => _googleMapController = controller,

                    /// here I used [_markers] Set to declare the markers
                    // markers: _markers,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [HomeButtonWidget()],
                  ),
                )),

            /// I used this position for pin widgets Floating widgets at the bottom of screen position
            Positioned(bottom: 0, child: _floatingWidget()),
          ],
        ),
      ),
    );
  }

  Widget _floatingWidget() {
    Taxi _taxi = Provider.of<RequestController>(context).taxi;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          _taxi.price.toString(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'سعر تقريبي',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              _taxi.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              _taxi.vechileType,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () async {
                                String number =
                                    _taxi.mobile; //set the number here
                                bool? res =
                                    await FlutterPhoneDirectCaller.callNumber(
                                        number);
                              },
                              child: Text(
                                _taxi.mobile,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffFF4100)),
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              radius: 37,
                              backgroundImage: NetworkImage(_taxi.image),
                            ))
                      ],
                    )
                  ],
                ),
                Container(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffFF4100)),
                      borderRadius: BorderRadius.circular(9)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '...اكتب رسالة',
                            style: TextStyle(color: Color(0xff707070)),
                          ),
                          Container(
                            width: 10,
                          ),
                          SvgPicture.asset('assets/svgs/msg.svg')
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: MediaQuery.of(context).size.width * 0.14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 3)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(),
                          Text(
                            'خلال 8 دقائق',
                            style: TextStyle(fontSize: 21),
                          ),
                          SvgPicture.asset(
                            'assets/svgs/clock.svg',
                            color: Color(0xffFF4100),
                            width: 25,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
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
                                    Navigator.of(context)
                                        .pop(false); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'نعم',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Provider.of<RequestController>(context,
                                            listen: false)
                                        .cancelRequest();
                                    Navigator.of(context).pop(true);

                                    // Perform the action you want here
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
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Color(0xffFF4100),
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 2),
                                blurRadius: 3)
                          ],
                        ),
                        child: Center(
                            child: Text(
                          'الغاء الرحلة',
                          style: TextStyle(fontSize: 21, color: Colors.white),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
