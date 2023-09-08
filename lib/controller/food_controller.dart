import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jayak/layout/food_layout.dart';
import 'package:jayak/model/cart.dart';
import 'package:jayak/model/meal.dart';
import 'package:http/http.dart' as http;
import 'package:jayak/model/restaurant.dart';
import 'package:jayak/model/search.dart';
import 'package:jayak/utils/constant.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../location_service.dart';
import '../model/food_filter.dart';

class FoodController extends ChangeNotifier {
  int navIndex = 0;
  int favorateIndex = 0;
  String? token;
  LatLng? userLocation;
  int selectedPlace = 0;
  Cart cart = Cart();
  List places = [];
  List<FoodFilter> filters = [];
  String? cardId;
  List _layouts(BuildContext context) {
    return [
      homeLayout(context),
      resturantsLayout(context),
      SliverChildListDelegate([]),
      favorateLayout(context),
      discountLayout(context)
    ];
  }

  currentLayout(BuildContext context) {
    return _layouts(context)[navIndex];
  }

  int? selected;

  List<Meal> meals = [];

  void changeSelected(int id) {
    if (selected == id) {
      selected = null;
    } else {
      selected = id;
    }
    notifyListeners();
  }

  void changeIsLiked(Meal meal) {
    meal.changeIsLiked();
    notifyListeners();
  }

  changeNavIndex(int value) {
    navIndex = value;
    notifyListeners();
  }

  changeFavorateIndex(int value) {
    favorateIndex = value;
    notifyListeners();
  }

  void setToken(String? to) {
    token = to;
    notifyListeners();
  }

  Future<http.Response> getMostSaleFood() async {
    print(token);
    return http.get(Uri.parse(mostSaleFoodUrl(places[selectedPlace]['id'])),
        headers: {"Authorization": 'Bearer ${token.toString()}'});
  }

  Future<http.Response> getNearRestaurants() async {
    return http.get(Uri.parse(nearResturantUrl(places[selectedPlace]['id'], selected!=null? filters[selected!].id:null)),
        headers: {"Authorization": 'Bearer ${token.toString()}'});
  }

  Future<LatLng> _getUserLocation() async {
    final value = await LocationService.determinePosition();
    userLocation = LatLng(value.latitude, value.longitude);
    notifyListeners();
    return LatLng(value.latitude, value.longitude);
  }
  void addFilters(List<FoodFilter> filters){
    this.filters = filters;
    notifyListeners();
  }
  Future<http.Response> getCategoryList() {
    return http.get(Uri.parse(categoryListUrl), headers: {
      "Authorization": 'Bearer ${token.toString()}',
      "Accept": "application/json"
    });
  }

  Future<void> getPlaceList() async {
    http.Response _res = await http.get(Uri.parse(placeListUrl), headers: {
      "Authorization": 'Bearer ${token.toString()}',
    });
    print('places');
    print(_res.body);
    if (_res.statusCode == 200) {
      Map json = jsonDecode(_res.body);
      if (json['status']) {
        print(json);
        places = json['data'];
        notifyListeners();
      }
    }
  }

  void changeSelectedPlace(int index) {
    selectedPlace = index;
    notifyListeners();
  }

  Future<http.Response?> getRestaurants() async {
    try {
      return http.get(Uri.parse(nearResturantUrl(places[selectedPlace]['id'], null)),
          headers: {"Authorization": 'Bearer ${token.toString()}'});
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getresturantById(int id) async {
    http.Response _res = await http.get(
        Uri.parse(
          getRestaurantByIdUrl(id),
        ),
        headers: {
          "Authorization": 'Bearer ${token.toString()}',
        });
    if (_res.statusCode == 200) {
      try {
        Map json = jsonDecode(_res.body);

        if (json['status']) {
          print(json);
          Restaurant restaurant =
              Restaurant.fromJson({...json['data'], 'id': id});

          List<FoodFilter> foodFilters = [];
          List<Meal> foods = [];
          json['data']['foods'].forEach((e) async {
            foodFilters.add(FoodFilter.fromJson(e['categories']));
            for (var element in e['food']) {
              foods.add(Meal.fromJson(element));
            }
          });
          Map<String, dynamic> map = {
            "restaurant": restaurant,
            "cats": foodFilters,
            "foods": foods
          };
          return map;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void addFoodToCart(Meal meal) {
    cart.addToCart(meal);
    notifyListeners();
  }

  void removeCartItem(int index) {
    cart.removeItem(index);
    notifyListeners();
  }
  void clearCart() {
    cart.clearCart();
    notifyListeners();
  }

  void removeCartMeal(int index) {
    cart.removeMeal(index);
    notifyListeners();
  }

  void addCartItem(int index) {
    cart.addItem(index);
    notifyListeners();
  }

  void addCartItemWithMealId(int id) {
    cart.foods.where((element) => element.meal.id == id).first.addItem();
  }

  void removeCartItemWithMealId(int id) {
    cart.foods.where((element) => element.meal.id == id).first.removeItem();
  }

  void removeCartMealWithMealId(int id) {
    cart.foods.remove((element) => element.meal.id == id);
  }

  Future<http.Response> getFavorateFood() {
    return http.get(Uri.parse(getFavorateFoodUrl(places[selectedPlace]['id'])),
        headers: {"Authorization": 'Bearer ${token.toString()}'});
  }

  Future<http.Response> getFavorateResturants() {
    return http.get(
        Uri.parse(getFavorateResturantsUrl(places[selectedPlace]['id'])),
        headers: {"Authorization": 'Bearer ${token.toString()}'});
  }

  Future<http.Response?> geiDiscounted() async {
    try {
      var future = http.get(
          Uri.parse(discountedUrl(places[selectedPlace]['id'])),
          headers: {"Authorization": 'Bearer ${token.toString()}'});
      print((await future).body);
      return future;
    } catch (e) {
      throw e;
    }
  }

  Future search(String text, SearchType type) {
    print(text);
    switch (type) {
      case SearchType.FavorateResturants:
        return http.get(
            Uri.parse(
                restaurantFavoriteSearch(text, places[selectedPlace]['id'])),
            headers: {"Authorization": 'Bearer ${token.toString()}'});
      case SearchType.favorateFood:
        return http.get(
            Uri.parse(foodFavoriteSearch(text, places[selectedPlace]['id'])),
            headers: {"Authorization": 'Bearer ${token.toString()}'});
      case SearchType.restaurant:
        return http.get(
            Uri.parse(restaurantSearch(text, places[selectedPlace]['id'])),
            headers: {"Authorization": 'Bearer ${token.toString()}'});

      default:
        return http.get(
            Uri.parse(foodFavoriteSearch(text, places[selectedPlace]['id'])),
            headers: {"Authorization": 'Bearer ${token.toString()}'});
    }
  }

  Future<void> addFoodToFavorate(int foodId) async {
    try {
      http.Response _res = await http.post(Uri.parse(addFoodToFavorateUrl),
          body: {
            'food_id': foodId.toString(),
            'place_id': places[selectedPlace]['id'].toString()
          },
          headers: {
            "Authorization": 'Bearer ${token.toString()}'
          });
      print(jsonDecode(_res.body));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<Map?> checkout() async {
    List _data = [
      ...cart.foods.map((e) =>{'id':e.meal.id, 'quantity':e.num})
    ];
    print(jsonEncode({
          'data':_data,
          'place_id': places[selectedPlace]['id'].toString()
        }));
    try {
      
    http.Response _res = await http.post(Uri.parse(cartPriceUrl),
        headers: {"Authorization": 'Bearer ${token.toString()}', 'Accept':'application/json', 'Content-Type':'application/json'},
        body: jsonEncode({
          'data':_data,
          'place_id': places[selectedPlace]['id']
        }));
        print(_res.body);
        if (_res.statusCode == 200) {
          Map _json = jsonDecode(_res.body);
          if(_json['status']){
            cardId = _json['data']['card_id'];
            notifyListeners();
            return _json['data'];
          }
          throw 'e';
        }else{
          throw jsonEncode({
          'data':_data,
          'place_id': places[selectedPlace]['id'].toString()
        });
        }
    } catch (e) {
      throw e;
    }
  }

  Future <void> addPlace(LatLng latLng, String name)async{
     try {
       
     
      http.Response _res = await http.post(Uri.parse(addPlaceUrl),
        headers: {"Authorization": 'Bearer ${token.toString()}', 'Accept':'application/json', 'Content-Type':'application/json'},
        body: jsonEncode({
          "lat":latLng.latitude,
          "lng":latLng.longitude,
          "name": name
        }));
        if (_res.statusCode == 200) {
           Map _json = jsonDecode(_res.body);
          if(_json['status']){
            notifyListeners();
          }
          throw json;
        }else{
          throw _res.body;
        }
        
     } catch (e) {
       print(e);
            }
  }
    late WebSocket socket;
    void socketConnect(){
    socket = WebSocket(Uri.parse(userConnect(LatLng(33.29842179542057, 44.40035921881266), token!)));
    notifyListeners();
    socket.messages.listen((event) {
      print(event);
    });

    }

 void _sendMeassage(message) {
    socket.send(jsonEncode(message));
  }
sendOrder(){
  _sendMeassage({
    "card_id":cardId,
    "type":"10"
  });
}
cnacelRequest(){
  _sendMeassage({
    "type":"11"
  });
}
  
}
enum orderState{
  START_ORDER
}
