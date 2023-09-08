import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak/controller/food_controller.dart';
import 'package:jayak/model/search.dart';
import 'package:jayak/view/widgets/food_home_widgets/resturant_list.dart';
import 'package:jayak/view/widgets/pop.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String hint;
  final SearchType searchType;
  const SearchScreen({
    super.key,
    required this.hint,
    required this.searchType,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  String text = '';
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: PopWidget(),
            centerTitle: true,
            title: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/svgs/jayak.svg',
                width: 70,
              ),
            ),
            actions: [HomeButtonWidget()],
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(10),
            child: TextField(
              focusNode: _focusNode,
              onSubmitted: (value) {
                _focusNode.unfocus();
              },
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.search),
                  labelText: widget.hint,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFF4100)))),
            ),
          ),
          FutureBuilder(
              future: Provider.of<FoodController>(context)
                  .search(text, SearchType.restaurant),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('حصل خطأ'));
                }
                if (snapshot.data==null) {
                  return Center(child: CircularProgressIndicator(),);
                }
                List _list = widget.searchType == SearchType.favorateFood? jsonDecode(snapshot.data.body)['data']['data'].map((e)=>Search.fromJson(e, widget.searchType)).toList():jsonDecode(snapshot.data.body)['data']['data'].map((e)=>Search.fromJson(e, widget.searchType)).toList()  ; 
                return Column(
                  children:[..._list.map((e) => 
                 SearchWidget(name: e.name, image: e.image,)
                )]);
              }),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    required this.name,
    required this.image,
    super.key,
  });
final String name;
final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 2)
        ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Container(width: 10),
            FoodAvatar(url: image,)
          ],
        ),
      ),
    );
  }
}
