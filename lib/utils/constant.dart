import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String url = 'http://192.158.0.114';

String getPriceUrl(LatLng first, LatLng end) =>
    'http://192.168.0.114/api/get-price?from_lat=${first.latitude}&from_lng=${first.longitude}&to_lat=${end.latitude}&to_lng=${end.longitude}';

const String socketUrl = 'ws://192.168.0.114:6001';
String userConnect(Position pos) =>
    '$socketUrl/user-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=1|RNRJpdPL2RbHU4KzogQBZoHupV6vLe3q5Mhl7nJ3';
