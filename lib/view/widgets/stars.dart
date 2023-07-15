import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Stars extends StatefulWidget {
   Stars(this.number, {this.width, super.key});
  int number;
  double? width;
  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
     widget.number>0?SvgPicture.asset('assets/svgs/star_selected.svg', width:widget.width?? 10,):  SvgPicture.asset(
          'assets/svgs/star.svg',
          width:widget.width?? 10,
        ),
         widget.number>1?SvgPicture.asset('assets/svgs/star_selected.svg', width:widget.width?? 10,):  SvgPicture.asset(
          'assets/svgs/star.svg',
          width:widget.width?? 10,
        ),
       widget.number>2?SvgPicture.asset('assets/svgs/star_selected.svg', width:widget.width?? 10,):    SvgPicture.asset(
          'assets/svgs/star.svg',
          width:widget.width?? 10,
        ),
      widget.number>3?SvgPicture.asset('assets/svgs/star_selected.svg', width:widget.width?? 10,):     SvgPicture.asset(
          'assets/svgs/star.svg',
          width:widget.width?? 10,
        ),
        widget.number>4?SvgPicture.asset('assets/svgs/star_selected.svg', width:widget.width?? 10,):  SvgPicture.asset(
          'assets/svgs/star.svg',
          width:widget.width?? 10,
        )
      ],
    );
  }
}
