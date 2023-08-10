import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FoodController>(context, listen: false).getPlaceList();
  }
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
            centerTitle: true,
            snap: true,
            title: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return BottomSheet(
                      backgroundColor: Colors.transparent,
                      onClosing: () {},
                      builder: (context) => PlacesBottomSheet(),
                    );
                  },
                );
              },
              child: SvgPicture.asset(
                'assets/svgs/jayak.svg',
                width: 70,
              ),
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

class PlacesBottomSheet extends StatefulWidget {
  const PlacesBottomSheet({
    super.key,
  });

  @override
  State<PlacesBottomSheet> createState() => _PlacesBottomSheetState();
}

class _PlacesBottomSheetState extends State<PlacesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'حدد الموقع',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'لمشاهدة المطاعم الملائمة حدد موقعك',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            ...Provider.of<FoodController>(context).places.map((e)=> PlaceWidget(),)
            , TextButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Column(
                                children: [
                                  Container(
                                    // width: MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          GoogleMap(
                                              initialCameraPosition:
                                                  CameraPosition(
                                                      target: Provider.of<
                                                                  FoodController>(
                                                              context)
                                                          .userLocation!,
                                                      zoom: 17)),
                                          Center(
                                            child: SvgPicture.asset(
                                              'assets/svgs/pin.svg',
                                              width: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'اسم العنوان'),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('اضافة عنوان'))
                                ],
                              ),
                            ),
                          ));
                },
                child: Text('اضافة موقع جديد'))
          ],
        ),
      ),
    );
  }
}

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(11)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(), shape: BoxShape.circle),
                child: Center(
                    child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                )),
              ),
              Center(
                  child: Text(
                'data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
