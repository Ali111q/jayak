import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/model/request.dart';
import 'package:jayak/model/request_price.dart';
import 'package:jayak/model/taxi.dart';
import 'package:jayak/view/request_loading_screen.dart';
import 'package:jayak/view/wait_driver_screen.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class RequestController extends ChangeNotifier {
  late GoogleMapController googleMapController;
  late GoogleMapController waitGoogleMapController;
  Request request = Request();
  RequestPrice? price;
  late WebSocket socket;
  Set<LatLng> points = {};
  Set<Marker> markers = {};
  RequestState state = RequestState.firstPoint;
  int? selectedPrice;
  CameraUpdate? cameraPosition;
  late Taxi taxi;
  Set<Marker> waitMarkers = {};

  late BuildContext appContext;
  void socketConnect(Position pos, BuildContext context) {
    // Create a WebSocket client.
    socket = WebSocket(Uri.parse(userConnect(pos)));

    notifyListeners();
// Listen to messages from the server.
    socket.messages.listen((message) {
      var json = jsonDecode(message);
      print(message);
      appContext = context;
      if (json['state'] == 2) {
        waitMarkers.add(markers.first);
        state = RequestState.accepted;
        taxi = Taxi.fromJson(json);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WaitDriverScreen()));

        _changeWaitCamera();
        waitMarkers
            .add(Marker(markerId: MarkerId(taxi.id), position: taxi.latLng));
      } else if (json['state'] == 9) {
        taxi.latLng = LatLng(json['lat'], json['lng']);
        waitMarkers.remove(waitMarkers.last);
        waitMarkers
            .add(Marker(markerId: MarkerId(taxi.id), position: taxi.latLng));

        _changeWaitCamera();
      }
    });
    notifyListeners();
  }

  void requestButton(LatLng pos) async {
    if (state == RequestState.secondPoint) {
      _addPoint(pos).then((value) {
        cameraPosition = _changeCamera();
        googleMapController.animateCamera(cameraPosition!);
      });
      await getPrice();
      notifyListeners();
    } else if (state == RequestState.firstPoint) {
      _addPoint(pos);
      state = RequestState.secondPoint;
      notifyListeners();
    }
  }

  void clearMarker(LatLng pos) {
    markers.remove(markers.last);
    points.remove(points.last);
    request.end = null;
    request.endName = null;
    // state = RequestState.firstPoint;
    print(markers);
    notifyListeners();
  }

  void _addMarker(LatLng pos) async {
    Marker _marker = Marker(
      markerId: MarkerId(pos.latitude.toString()),
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, 'assets/images/crosshair.png'),
      position: pos,
    );
    markers.add(_marker);
  }

  Future<void> _addPoint(LatLng pos) async {
    points.add(pos);
    _addMarker(pos);
    notifyListeners();
  }

  void _sendMeassage(message) {
    print(message);
    socket.send(jsonEncode(message));
  }

  CameraUpdate _changeCamera() {
    LatLngBounds bound = boundsFromLatLngList([points.first, points.last]);

    return CameraUpdate.newLatLngBounds(bound, 50);
  }

  void _changeWaitCamera() {
    LatLngBounds _bound = boundsFromLatLngList([points.first, taxi.latLng]);

    CameraUpdate _cameraUpdate = CameraUpdate.newLatLngBounds(_bound, 100);
    waitGoogleMapController.animateCamera(_cameraUpdate);
    notifyListeners();
  }

  MapTarget calculateMapTarget() {
    final double lat1 = points.first.latitude; // Latitude of marker 1
    final double lon1 = points.first.longitude; // Longitude of marker 1
    final double lat2 = points.last.latitude; // Latitude of marker 2
    final double lon2 = points.last.longitude; // Longitude of marker 2

    final double distance = calculateDistance(lat1, lon1, lat2, lon2);
    final double zoomLevel = getZoomLevel(distance);

    final double centerLatitude = (lat1 + lat2) / 2;
    final double centerLongitude = (lon1 + lon2) / 2;

    return MapTarget(
      zoom: zoomLevel.roundToDouble(),
      centerLatitude: centerLatitude,
      centerLongitude: centerLongitude,
    );
  }

  clearAllPoints() {
    points.clear();
    markers.clear();
    request.start = null;
    request.startName = null;
    request.end = null;
    request.endName = null;
    state = RequestState.firstPoint;
    notifyListeners();
  }

  Future<void> getPrice() async {
    http.Response _res =
        await http.get(Uri.parse(getPriceUrl(points.first, points.last)));
    print('object');

    print(_res.statusCode);

    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['status']) {
        price = RequestPrice.fromJson(json['data']);
        notifyListeners();
      }
    }
  }

  void changeRequestPoints(LatLng pos) async {
    List adress = await GeocodingPlatform.instance.placemarkFromCoordinates(
        pos.latitude, pos.longitude,
        localeIdentifier: 'ar');

    Placemark _placeMark = adress[0];

    if (state == RequestState.firstPoint) {
      String street;
      if (_placeMark.thoroughfare != null) {
        if (_placeMark.thoroughfare!.split('').contains('-')) {
          street = '';
        } else {
          street = _placeMark.thoroughfare!;
        }
      } else {
        street = '';
      }
      request.startName = '${_placeMark.locality} ${street}';
      request.start = pos;
      notifyListeners();
    } else if (state == RequestState.secondPoint) {
      String street;
      if (_placeMark.thoroughfare != null) {
        if (_placeMark.thoroughfare!.split('').contains('-')) {
          street = '';
        } else {
          street = _placeMark.thoroughfare!;
        }
      } else {
        street = '';
      }
      request.endName = '${_placeMark.locality} ${street}';
      request.end = pos;
      notifyListeners();
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    final p = 0.017453292519943295; // Math.PI / 180
    final c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  double getZoomLevel(double distance) {
    final double mapWidthInPixels = 1170;
    final double zoomScale = distance * 1000 / (mapWidthInPixels * 256);
    return log(360 / zoomScale);
  }

  void initializeMap(GoogleMapController controller) =>
      googleMapController = controller;

  void changeSelectedPrice(int price) {
    if (selectedPrice == price) {
      request.carType = null;
      selectedPrice = null;
    } else {
      selectedPrice = price;
      request.carType = price;
    }
    notifyListeners();
  }

  void sendRequest() async {
    if (request.carType != null) {
      DateTime _time = DateTime.now();
      print('object');
      _sendMeassage(request.toJson());
      state = RequestState.requested;
      while (state == RequestState.requested) {
        if (DateTime.now().difference(_time) <= Duration(minutes: 5)) {
          await Future.delayed(Duration(minutes: 1));
          _sendMeassage(request.toJson());
        } else {
          state = RequestState.secondPoint;
          Navigator.of(appContext).pop();
        }
      }
      notifyListeners();
    }
  }

  void cancelRequest() {
    _sendMeassage({"type": "2"});
    state = RequestState.firstPoint;
    notifyListeners();
  }

  initWaitMapController(GoogleMapController con) {
    waitGoogleMapController = con;
    notifyListeners();
  }
}

enum RequestState {
  firstPoint,
  secondPoint,
  priceChecked,
  requested,
  accepted,
  inTheHouse,
}

class MapTarget {
  final double zoom;
  final double centerLatitude;
  final double centerLongitude;

  MapTarget(
      {required this.zoom,
      required this.centerLatitude,
      required this.centerLongitude});
}

LatLngBounds boundsFromLatLngList(List<LatLng> list) {
  assert(list.isNotEmpty);
  double? x0, x1, y0, y1;
  for (LatLng latLng in list) {
    if (x0 == null) {
      x0 = x1 = latLng.latitude;
      y0 = y1 = latLng.longitude;
    } else {
      if (latLng.latitude > x1!) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1!) y1 = latLng.longitude;
      if (latLng.longitude < y0!) y0 = latLng.longitude;
    }
  }
  return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
}
