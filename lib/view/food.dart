import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/layout/food_layout.dart';
import 'package:jayak/view/widgets/food_home_widgets/food_search.dart';
import 'package:jayak/view/widgets/navbar.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:provider/provider.dart';

import '../controller/language_controller.dart';
import '../utils/words.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    dynamic _currentLayout =
        Provider.of<FoodController>(context).currentLayout(context);
    int _currenIndex = Provider.of<FoodController>(context).navIndex;
    Words _words = Provider.of<LanguageController>(context).words;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: PopWidget(),
            pinned: false,
            floating: true,
            snap: true,
            title: SvgPicture.asset(
              'assets/svgs/jayak.svg',
              width: 70,
            ),
            actions: [HomeButtonWidget()],
          ),
          if (_currenIndex == 4)
            SliverList(
                delegate: SliverChildListDelegate([
              FoodSearch(
                hint: _words.searchhint(),
              ),
            ])),
          if (_currenIndex != 4)
            SliverList(
              delegate: _currentLayout,
            )
          else
            _currentLayout,
        ],
      ),
      extendBody: true,
      bottomNavigationBar: NavBar(),
    );
  }
}
