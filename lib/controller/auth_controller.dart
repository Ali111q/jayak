import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/service/shared_service.dart';
import 'package:http/http.dart' as http;
import 'package:jayak/utils/constant.dart';
import 'package:jayak/view/register.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../model/user.dart';
import '../view/home.dart';

class AuthController extends ChangeNotifier {
  User? user;
  bool waitingForVerfication = true;
  int? userId;
  String? userToken;
  SharedService _sharedService = SharedService();
  Future<String?> getUserFromShared() async {
    await _sharedService.initialize();
    user = await _sharedService.getUser();
    
    notifyListeners();
    return user?.token;
  }
  bool isLogedIn() => user != null;
  
  Future<void> login(String phoneNumber) async {
    http.Response _res = await http.post(Uri.parse(loginUrl), body: {
      "mobile": phoneNumber
    });
    print(_res.body);
    if (_res.statusCode == 200) {
      Map json = jsonDecode(_res.body);

      if (json['status']) {
        userId = json['data']['id']??json['data']['user']['id'];
        waitingForVerfication = true;
        notifyListeners();
      } else {
        Toast.show(json['message']);
        throw "";
      }
    } else {
      Toast.show("حصل خطأ ما");
    throw "";
    }
  }

  Future<void> loginCheck(String otp, BuildContext context)async{


    http.Response _res = await http.post(Uri.parse(loginCheckUrl), body: {
      "user_id":userId.toString(),
      "code":otp
    });


print(_res.body);
    if (_res.statusCode == 200) {
      Map json = jsonDecode(_res.body);
      if (json['status']) {
        if (json['data']['user']['interface']=="complete_register") {
          userToken = json['data']['user']['token'];
          notifyListeners();
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => Register(),));
        }else{

       user  = User.fromJson(json['data']['user']);
        waitingForVerfication = false;
        _sharedService.saveUser( user!);
        notifyListeners();
                            Provider.of<FoodController>(context, listen: false).setToken(user!.token);

          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

        }
      } else {
        Toast.show(json['message']);
      }
    } else {
      Toast.show("حصل خطأ ما");
    }


      
  }

   Future<void> register(Map<String, dynamic> register, BuildContext context) async {
    final Map<String, dynamic> jsonData = register;
    print(jsonData['back_residence']);
    final http.Response _res =
        await http.post(Uri.parse(registerUrl), body: jsonEncode(jsonData), headers: {
          'Authorization':'Bearer $userToken',
          "Content-Type":"application/json"
        });

    print(_res.body);
    if (_res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(_res.body);

      if (json['status']) {
      user  = User.fromJson(json['data'], token: this.userToken);
        waitingForVerfication = false;
        _sharedService.saveUser( user!);
        notifyListeners();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:((context) => HomeScreen())), (route) => false);
       
      } else {
        Toast.show(json['message']);
        throw "";
      }
    } else {
      Toast.show("حصل خطأ ما");
      throw "";
    }
  }
  void logout(){
    _sharedService.clear();
  }

}
