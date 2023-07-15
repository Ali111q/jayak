import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak/view/widgets/stars.dart';
import 'package:provider/provider.dart';

import '../../../controller/language_controller.dart';
import '../../../utils/words.dart';

class ResturantSlider extends StatelessWidget {
  const ResturantSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
        RestaurantsSliderWidget(),
      ],
    );
  }
}

class RestaurantsSliderWidget extends StatefulWidget {
  const RestaurantsSliderWidget({super.key});

  @override
  State<RestaurantsSliderWidget> createState() =>
      _RestaurantsSliderWidgetState();
}

class _RestaurantsSliderWidgetState extends State<RestaurantsSliderWidget> {
  @override
  Widget build(BuildContext context) {
    Words _words = Provider.of<LanguageController>(context).words;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        children: [
          Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(22),
                elevation: 3,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            stops: [0.2, 0.4, 0.8],
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0.0)
                            ],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.37,
                          decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10)
                              ],
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/test_images/food_slider.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3111,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stars(
                                      3,
                                      width: 15,
                                    ),
                                    Text(
                                      'مطعم شكسبير',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                                offset: Offset(0, 2),
                                                color: Colors.white
                                                    .withOpacity(0.2))
                                          ]),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 20,
                                ),
                                Text(
                                  'تبدوا مهمة اختيار العبارة المثالية لمطعمك امرا شاقا ويحتاج الكثير من التفكير والوقت، لكن لا تقلق فستوفر عليك هذه المقالة العناء بتزويدك ببعض النصائح',
                                  style: TextStyle(fontSize: 18, shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(0.14),
                                        offset: Offset(0, 1))
                                  ]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(22),
                                          bottomRight: Radius.circular(22)),
                                      gradient: LinearGradient(
                                          stops: [0, 0.5, 1],
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0.8),
                                            Colors.white.withOpacity(0.1),
                                          ])),
                                  child: PriceWidget(),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xffFF4100),
                                    child: SvgPicture.asset(
                                        'assets/svgs/food_home.svg'),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(22),
                                          bottomLeft: Radius.circular(22)),
                                      gradient: LinearGradient(
                                          stops: [0, 0.5, 1],
                                          end: Alignment.centerRight,
                                          begin: Alignment.centerLeft,
                                          colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0.8),
                                            Colors.white.withOpacity(0.1),
                                          ])),
                                  child: TimeWidget(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
          Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width * 0.9,
              // right: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                                'assets/svgs/double_arrow_back.svg'),
                            Text(_words.mainPage()),
                            Container()
                          ],
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
   TimeWidget({
    this.textColor= Colors.black,
    this.iconColor = const Color(0xffFF4100),
    this.mainAxisAlignment = MainAxisAlignment.start,
    super.key,
  });
Color textColor;
Color iconColor;
MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          width: 3,
        ),
        Padding(
          padding: const EdgeInsets.only( bottom: 5.0),
          child: SvgPicture.asset(
            'assets/svgs/clock.svg',
            color: iconColor,
            width: 22,
          ),
        ),
        Container(
          width: 3,
        ),
        Text(
          '25m - 45m',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
   PriceWidget({
        this.textColor= Colors.black,
    this.iconColor = const Color(0xffFF4100),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.fontSize = 15,
    this.width = 30,
    super.key,
  });
  Color textColor;
Color iconColor;
MainAxisAlignment mainAxisAlignment;
double width;
double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding: const EdgeInsets.only( bottom: 8.0),
          child: SvgPicture.asset(
              'assets/svgs/price2.svg', width: width,color: iconColor,),
        ),
        Container(
          width: 3,
        ),
        Text(
          '1,500 IQD',
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
