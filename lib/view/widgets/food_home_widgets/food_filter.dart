import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/model/food_filter.dart';
import 'package:provider/provider.dart';

class FoodFilterSlider extends StatelessWidget {
  const FoodFilterSlider({super.key});

  @override
  Widget build(BuildContext context) {

    List foodFilter = Provider.of<FoodController>(context).foodFilters;
    return SingleChildScrollView( scrollDirection: Axis.horizontal, child: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: FutureBuilder(
        future: Provider.of<FoodController>(context, listen: false).getCategoryList(),
        builder: (context, snapshot) {
          List<FoodFilter>? cats;
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              Map json = jsonDecode(snapshot.data!.body);
          if (json['status']) {
            cats = [...json['data'].map((e)=>FoodFilter.fromJson(e))];
          }
            }
          }
          return Row(children: [
          if(cats!=null)  ...cats.map((e) => FoodFilterWidget(e))
          ],);
        }
      ),
    ),);
  }
}

class FoodFilterWidget extends StatelessWidget {
   FoodFilterWidget( this.filter,  {this.clickable = true, super.key});
  FoodFilter filter;
  bool clickable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (clickable) {
        filter.setSelcted(context);
          
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.all(5),
        height: 77,width: 67,
    
      decoration: BoxDecoration(
        border: filter.isSelcted(context)? Border.all(color: Color(0xffFF4100)):null,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff647B9A).withOpacity(0.1),
            blurRadius: 10
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
          SvgPicture.network(filter.image),
          Text(filter.name, style: TextStyle(color: Color(0xffFF4100), fontSize: 12),)
        ],),
      ),
      ),
    );
  }
}