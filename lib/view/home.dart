import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/language_controller.dart';
import 'package:jayak/data/home_widgets.dart';
import 'package:jayak/utils/colors.dart';
import 'package:jayak/utils/words.dart';
import 'package:jayak/view/widgets/settings_bottomsheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/logo.svg',
                        color: MyColors.primary,
                        width: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context, builder:(context) => SettingsButtomSheet(),);
                        },
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(7),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset('assets/svgs/setting.svg'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 30,
                ),
                ...homeWidgets.map((e) => HomeWidget(width: e['width'], colros: e['colors'], image: e['image'], index: e['index'],route: e['route'], ))]
            ),
          ),
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
   HomeWidget({
    required this.width,
    required this.colros,
    required this.image, required this.index,
    required this.route, super.key,
  });
  double width;
  List<Color> colros;
  String image;
  int index;
  String route;
  @override
  Widget build(BuildContext context) {
    Words _words = Provider.of<LanguageController>(context).words;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.19,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colros)),
        child: Stack(
    
          children: [
         
        
            Positioned(
              right: 0,
              bottom: -5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    image,
                    width: MediaQuery.of(context).size.width *width,
                  ),
               if(index!=1)   Container(height: 20,)
                ],
              ),
            ),
                Positioned(
              left: 30,
              child: Column(
                
                children: [
                  Text(
                    _words.HomeScreen()[index],
                    style: TextStyle(color: Colors.white, fontSize: 45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
