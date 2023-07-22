import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Request {
  LatLng? start;
  LatLng? end;
  String? startName;
  String? endName;
  int type = 1;
  int? carType;
  Map<String, dynamic>? toJson() {
    if (end != null) {
      return {
        "type": type,
        "car_type": carType,
        "from_lat": start!.latitude,
        "from_lng": start!.longitude,
        "to_lat": end!.latitude,
        "to_lng": end!.longitude
      };
    }
    return null;
  }
}
