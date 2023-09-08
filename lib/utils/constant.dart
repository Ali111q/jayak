import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String url = 'wss://jayk.dorto-dev.com:6001';

String getPriceUrl(LatLng first, LatLng end) =>
    '$url/api/get-price?from_lat=${first.latitude}&from_lng=${first.longitude}&to_lat=${end.latitude}&to_lng=${end.longitude}';

const String socketUrl = 'wss://jayk.dorto-dev.com:6001';
String userConnect(LatLng pos, String token) =>
    '$socketUrl/user-socket/osamah?lat=${pos.latitude}&lng=${pos.longitude}&token=$token';

const String loginUrl = '$url/api/auth/login';
const String loginCheckUrl = '$url/api/auth/login/check-code';
String mostSaleFoodUrl(int placeId) => "$url/api/restaurant/home/most-food-sail?place_id=${placeId.toString()}";
String discountedUrl(int placeId) => "$url/api/restaurant/home/restaurants-discounted?place_id=$placeId";
String nearResturantUrl (int placeId, int? catId)=>"$url/api/restaurant/home/near-restaurants?place_id=${placeId.toString()}&category_id=${catId??''}";
const String categoryListUrl = "$url/api/restaurant/home/categories";
const String placeListUrl = '$url/api/restaurant/favorite/place';
String getRestaurantByIdUrl(int id)=>'$url/api/restaurant/foods?restaurant_id=${id.toString()}';
String getFavorateFoodUrl(int id)=>'$url/api/restaurant/favorite/food?place_id=$id';
String getFavorateResturantsUrl(int id)=>'$url/api/restaurant/favorite/restaurant?place_id=$id';
String restaurantFavoriteSearch(String text, int placeId)=>'$url/api/restaurant/favorite/restaurant?place_id=$placeId&search=$text';
String foodFavoriteSearch(String text, int placeId)=>'$url/api/restaurant/favorite/food?place_id=$placeId&search=$text';
String restaurantSearch(String text, int placeId)=>'$url/api/restaurant/home/near-restaurants?place_id=$placeId&search=$text';
const String addFoodToFavorateUrl = '$url/api/restaurant/favorite/food/store';
const String addRestaurantToFavorateUrl = '$url/api/restaurant/favorite/restaurant/store';
const String cartPriceUrl = '$url/api/restaurant/get_card_price';

const String registerUrl =  '$url/api/auth/register/complete';
const String addPlaceUrl =  '$url/api/restaurant/favorite/place/store';
