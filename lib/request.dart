import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/controller/request_controller.dart';
import 'package:jayak/location_service.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:jayak/view/widgets/point_widget.dart';

import 'package:jayak/view/widgets/request_widgets/request_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_client/web_socket_client.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late WebSocket socket;

  ///  this icon used as marker icon
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

  /// this is current user location
  LatLng? userLocation;
  late LatLng _mapPos;

  /// this controller use with [GoogleMap] to full control it
  /// you can set this controller by make it = onCreate[Function] value

  /// checking if the user moving the map for animate courser
  bool isMoving = false;
  //set of markers to put location of user
  //this class is built in dart class works like array
  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RequestController>(context, listen: false).clearAllPoints();
    _getUserLocation();

    /// set the asset image as marker icon
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
            'assets/images/crosshair.png')
        .then((d) {
      setState(() {
        icon = d;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    RequestController controller = Provider.of<RequestController>(context);
    Function()? _popHandler = controller.state == RequestState.secondPoint
        ? () {
            Provider.of<RequestController>(context, listen: false)
                .clearAllPoints();
            _getUserLocation();
          }
        : null;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        ///this google map widget
        ///this widget won't render until you add google map api key in AndroidManifest file
        GoogleMap(
          /// this is required parameter to pass initial position of map
          /// todo: make this parameter = current user location
          initialCameraPosition:
              CameraPosition(target: userLocation ?? LatLng(44, 33), zoom: 5),

          /// disable zoom control buttons
          zoomControlsEnabled: false,

          /// Enable user location courser
          myLocationEnabled: true,

          /// disable go to my location button
          /// in our case I disabled it for creating a custom button with custom ui
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          onCameraIdle: () async {
            /// when camera stop moving
            /// set [isMoving] false to animate courser to Idle setuation
            setState(() {
              isMoving = false;
            });
            Provider.of<RequestController>(context, listen: false)
                .changeRequestPoints(_mapPos);
          },
          onCameraMoveStarted: () {
            /// when camera is moving
            /// set [isMoving] true to animate courser to moving setuation
            setState(() {
              isMoving = true;
            });
          },
          onCameraMove: (position) async {
            setState(() {
              _mapPos = position.target;
            });
          },

          /// setting [GoogleMapContoller]
          onMapCreated: controller.initializeMap,

          /// here I used [_markers] Set to declare the markers
          markers: controller.markers,
        ),

        /// I used this position for pin widgets like app bar position
        Positioned(
            top: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopWidget(
                    onTap: _popHandler,
                  ),
                  HomeButtonWidget()
                ],
              ),
            )),

        /// I used this position for pin widgets Floating widgets at the bottom of screen position
        Positioned(bottom: 0, child: _floatingWidget()),
        if (controller.state == RequestState.firstPoint ||
            controller.state == RequestState.secondPoint)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: isMoving ? 20 : 40,
                    height: isMoving ? 20 : 40,
                    decoration: BoxDecoration(
                        color: isMoving
                            ? Color(0xffFF4100).withOpacity(0.1)
                            : Colors.transparent,
                        shape: BoxShape.circle),
                    child: isMoving
                        ? Center(
                            child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Color(0xffFF4100),
                                    shape: BoxShape.circle)),
                          )
                        : SvgPicture.asset('assets/svgs/pin.svg')),
                if (!isMoving)
                  Container(
                    height: 34,
                  )
              ],
            ),
          )
      ]),
    );
  }

  Widget _floatingWidget() {
    CameraUpdate? _pos = Provider.of<RequestController>(context).cameraPosition;
    void _buttonHandler() async {
      RequestController _controller =
          Provider.of<RequestController>(context, listen: false);
      RequestState _requestState = _controller.state;
      _controller.requestButton(_mapPos);
      if (_requestState == RequestState.secondPoint) {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (context) => RequestBottomSheet(),
        ).then((value) {
          _controller.clearMarker(_mapPos);
        });
        print(Provider.of<RequestController>(context, listen: false)
            .cameraPosition);
        if (_pos != null) {
          CameraUpdate _update = _pos;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: _getUserLocation,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Center(
                  child: Image.asset('assets/images/crosshair.png'),
                ),
              ),
            ),
          ),
        ),
        PointWidget(
          context: context,
          selected: false,
          tag: 'start',
        ),
        if (Provider.of<RequestController>(context).state ==
            RequestState.secondPoint)
          PointWidget(
            context: context,
            selected: false,
            tag: 'end',
          ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(5, 12, 5, 30),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.red)))),
              onPressed: _buttonHandler,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: Text(
                    'تأكيد نقطة الانطلاق',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )))),
        )
      ],
    );
  }

  Future<void> _getUserLocation() async {
    final value = await LocationService.determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        value.latitude, value.longitude,
        localeIdentifier: 'ar');
    print(value.heading);
    CameraUpdate _update = CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(value.latitude, value.longitude), zoom: 18));
    Provider.of<RequestController>(context, listen: false)
        .socketConnect(value, context);
    setState(() {
      userLocation = LatLng(value.latitude, value.longitude);
      Provider.of<RequestController>(context, listen: false)
          .googleMapController
          .animateCamera(_update);
    });
  }
}
