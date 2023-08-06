import 'package:flutter/material.dart';
import 'package:jayak/controller/auth_controller.dart';
import 'package:jayak/controller/language_controller.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/controller/request_controller.dart';
import 'package:jayak/request.dart';
import 'package:jayak/view/home.dart';
import 'package:jayak/view/login.dart';
import 'package:jayak/view/otp.dart';
import 'package:jayak/view/food.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageController>(
          create: (_) => LanguageController()),
      ChangeNotifierProvider<FoodController>(create: (_) => FoodController()),
      ChangeNotifierProvider<AuthController>(create: (_) => AuthController()),
      ChangeNotifierProvider<RequestController>(
          create: (_) => RequestController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _end = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthController>(context, listen: false)
        .getUserFromShared()
        .then((value) {
          Provider.of<FoodController>(context, listen: false).setToken(value);
      setState(() {
        _end = true;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return !_end
        ? Container()
        : MaterialApp(
            title: 'جايك',
            theme: ThemeData(
              fontFamily: 'font',
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: createMaterialColor(Color(0xffFF4100)),
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => HomeScreen(),
              '/launch': (context) => LoginScreen(),
              '/request': (context) => RequestScreen(),
              '/otp': (context) => OtpScreen(),
              '/food': (context) => Food()
            },
            initialRoute: Provider.of<AuthController>(context).isLogedIn()
                ? '/'
                : '/launch',
          );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {
    50: color.withOpacity(strengths[0]),
    100: color.withOpacity(strengths[0]),
    200: color.withOpacity(strengths[0]),
    300: color.withOpacity(strengths[0]),
    400: color.withOpacity(strengths[0]),
    500: color.withOpacity(strengths[0]),
    600: color.withOpacity(strengths[0]),
    700: color.withOpacity(strengths[0]),
    800: color.withOpacity(strengths[0]),
    900: color.withOpacity(strengths[0]),
  };
  return MaterialColor(color.value, swatch);
}
