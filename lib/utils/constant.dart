import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String url = 'http://192.158.0.114';

String getPriceUrl(LatLng first, LatLng end)=>'http://192.168.0.114/api/get-price?from_lat=33.31551774949114&from_lng=44.36647462599496&to_lat=33.311551774949115&to_lng=44.36647462599496';



const String socketUrl = 'ws://192.168.0.114:6001';
String userConnect(Position pos)=> '$socketUrl/user-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=1|Ieb2KS94fH2r4sYiZYA7iMSVclDQdBRPx164AXGg';