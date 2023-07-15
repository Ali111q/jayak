
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controller/food_controller.dart';

class FavorateTabBar extends StatelessWidget {
  const FavorateTabBar({
    super.key,

  }) ;

 

  @override
  Widget build(BuildContext context) {
  int _index = Provider.of<FoodController>(context).favorateIndex;

    return DefaultTabController(
      initialIndex: _index,
      
      length: 2, child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Color(0xffFF4100),
        onTap:         Provider.of<FoodController>(context, listen: false).changeFavorateIndex
,
        tabs: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('assets/svgs/food_home.svg', color:_index==0?Color(0xffFF4100): Colors.grey,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('assets/svgs/resturant.svg', color:_index==1?Color(0xffFF4100): Colors.grey,),
        ),

    ]));
  }
}