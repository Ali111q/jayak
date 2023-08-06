import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String url = 'http://10.0.2.2:8000';

String getPriceUrl(LatLng first, LatLng end) =>
    'http://10.0.2.2/api/get-price?from_lat=${first.latitude}&from_lng=${first.longitude}&to_lat=${end.latitude}&to_lng=${end.longitude}';

const String socketUrl = 'ws://10.0.2.2:6001';
String userConnect(Position pos) =>
    '$socketUrl/user-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=4|ByTV1loXpFcztSemUvdlHwkqI1FoaArTr4hAy8EO';

const String loginUrl = '$url/api/auth/login';
const String loginCheckUrl = '$url/api/auth/login/check-code';
const String mostSaleFoodUrl = "$url/api/restaurant/home/most-food-sail";
