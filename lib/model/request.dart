import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Request {
  LatLng? start;
  LatLng? end;
  String? startName;
  String? endName;
  int type = 1 ;
int? carType;
  Map<String, dynamic>? toJson() {
    if (end != null) {
      return {
        "type": type,
        "car_type": carType,
         "from_lat" : "33.31551774949114" , 
    "from_lng" : "44.36647462599496" ,
    "to_lat" : "33.31551774949114" , 
    "to_lng" : "44.36647462599496" 
      };
    }
    return null;
  }
}
