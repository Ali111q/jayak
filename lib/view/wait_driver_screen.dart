import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/view/widgets/pop.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
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
            onCameraMoveStarted: () {
              /// when camera is moving
              /// set [isMoving] true to animate courser to moving setuation
            },

            /// setting [GoogleMapContoller]
            // onMapCreated: (controller) => _googleMapController = controller,

            /// here I used [_markers] Set to declare the markers
            // markers: _markers,
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
    );
  }

  Widget _floatingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
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
                          '3,000',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'سعر تقريبي',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/car_number.svg',
                          width: 80,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'احمد خالد محي',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'تكتك صفراء',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '07724023987',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffFF4100)),
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              radius: 37,
                              backgroundImage:
                                  NetworkImage(Faker().image.image()),
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
                Container(height: 20,),
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
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(),
                          Text('خلال 8 دقائق', style: TextStyle(fontSize: 21),),SvgPicture.asset('assets/svgs/clock.svg', color: Color(0xffFF4100),width: 25,) ],
                      ),
                    ),
                     Container(
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
                      child: Center(child: Text('الغاء الرحلة', style: TextStyle(fontSize: 21, color: Colors.white),)),
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
