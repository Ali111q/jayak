import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/view/chart_screen.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {


  @override
  Widget build(BuildContext context) {
    int _currentIndex = Provider.of<FoodController>(context).navIndex;
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Color(0xffFF4100),
      
      onTap: (value) {
      

       Provider.of<FoodController>(context, listen: false).changeNavIndex(value);
        
      },
      index: _currentIndex,
      letIndexChange: (value) {
        if (value == 2) {
        return false;
        
      }
      return true;
      },
      animationDuration: Duration(milliseconds: 300),
      items: [
            SvgPicture.asset('assets/svgs/food_home.svg', color:_currentIndex == 0?Colors.white: Colors.grey,),
            SvgPicture.asset('assets/svgs/resturant.svg',color:_currentIndex == 1?Colors.white: Colors.grey),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => ChartScreen(),));
              },
              child: SvgPicture.asset('assets/svgs/chart.svg',color:_currentIndex == 2?Colors.white: Colors.grey)),
            SvgPicture.asset('assets/svgs/favorate.svg',color:_currentIndex == 3?Colors.white: Colors.grey),
            SvgPicture.asset('assets/svgs/discount.svg',color:_currentIndex == 4?Colors.white: Colors.grey),

    ]);
  }
}

// Container(
//   width: 200,
//   height: 200,
//   decoration: BoxDecoration(
//     color: Colors.blue,
//   ),
//   child: ShaderMask(
//     shaderCallback: (Rect bounds) {
//       return LinearGradient(
//         colors: [Colors.transparent, Colors.transparent, Colors.black],
//         stops: [0.0, 0.8, 1.0],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       ).createShader(bounds);
//     },
//     blendMode: BlendMode.dstOut,
//     child: Container(
//       color: Colors.white,
//       child: Center(
//         child: Text(
//           'Transparent Mask',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ),
//   ),
// )
