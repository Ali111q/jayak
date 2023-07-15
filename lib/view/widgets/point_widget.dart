import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jayak/controller/request_controller.dart';
import 'package:jayak/model/request.dart';
import 'package:jayak/view/location_search.dart';
import 'package:provider/provider.dart';

class PointWidget extends StatelessWidget {
   PointWidget({
    super.key,
    required this.context,
    required this.selected, required this.tag,
  });
  bool selected = false;
  final BuildContext context;
  final String tag;
  @override
  Widget build(BuildContext context) {
    RequestController _controller = Provider.of<RequestController>(context);
    Request _request = _controller.request; 
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.all(8),
   
      child: Container(
           decoration: selected? BoxDecoration(
        border: Border.all(color: Color(0xffFF4100), width: 2),
          borderRadius: BorderRadius.circular(8),

      ): null,
        child: Hero(
          tag: tag,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (contetx)=> LocationSearchScreen(tag: tag)));
            },
            child: Container(
              
              decoration: BoxDecoration(boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.1),
               offset: Offset(0, 2),
               blurRadius: 3 
              )]
              , color: Colors.white, borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(  horizontal: 8, vertical: 14),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 33,
                    ),
                    Expanded(
                        flex: 3,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: RichText( textDirection: TextDirection.rtl, 
                              text: TextSpan(children: [
                                TextSpan(
                                    text: tag=='start'? 'الانطلاق: ':'الوجهه: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'font',
                                        fontSize: 18)),
                                TextSpan(
                                    text: tag == 'start'? _request.startName??  '...':_request.endName??'...',
                                    style: TextStyle(
                                      fontFamily: 'font',
                                        color: Colors.black, fontSize: 15 ,fontWeight: FontWeight.w200)),
                              ]),
                            ))),
                    Container(
                      width: 10,
                    ),
                    SvgPicture.asset(tag=='start'?'assets/svgs/location.svg':'assets/svgs/square_location.svg'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}