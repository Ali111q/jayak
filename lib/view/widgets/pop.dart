import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopWidget extends StatelessWidget {
   PopWidget( { this.onTap , super.key});
   Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: onTap??  () {
        Navigator.of(context).pop();
        },
        child: Container(
              width: 50,
          height: 50,
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(8),
            child: Center(child: SvgPicture.asset('assets/svgs/pop.svg')),
          ),
        ),
      ),
    );
  }
}


class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () {
          print('object');
        },
        child: Container(
          width: 50,
          height: 50,
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(8),
            child: Center(child: SvgPicture.asset('assets/svgs/home.svg')),
          ),
        ),
      ),
    );
  }
}