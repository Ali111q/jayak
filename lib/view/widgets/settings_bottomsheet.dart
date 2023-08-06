import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsButtomSheet extends StatefulWidget {
  const SettingsButtomSheet({super.key});

  @override
  State<SettingsButtomSheet> createState() => _SettingsButtomSheetState();
}

class _SettingsButtomSheetState extends State<SettingsButtomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          Container(
            width: 45,
            height: 4,
            color: Color(0xff707070).withOpacity(0.5),
          ),
          Container(
            height: 30,
          ),
          BottomSheetWidget(
              name: 'الملف الشخصي', image: "assets/svgs/person.svg"),
          BottomSheetWidget(name: 'متوفر', image: "assets/svgs/available.svg"),
          BottomSheetWidget(name: 'اتصل بنا', image: "assets/svgs/contact.svg")
        ],
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key, required this.name, required this.image});
  final String name;
  final String image;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/profile');
      },
      child: Container(
        margin: EdgeInsets.all(7),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  offset: Offset(0, 2),
                  blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Row(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xffFF4100).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: SvgPicture.asset(widget.image),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
