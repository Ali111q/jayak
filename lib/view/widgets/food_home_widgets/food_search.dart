import 'package:flutter/material.dart';
import 'package:jayak/controller/language_controller.dart';
import 'package:jayak/utils/words.dart';
import 'package:provider/provider.dart';

class FoodSearch extends StatefulWidget {
   FoodSearch({ this.hint, super.key});
  String? hint;
  @override
  State<FoodSearch> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FoodSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() { });
  }
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
  Words _words = Provider.of<LanguageController>(context).words;
    return Container(
      height: 50,
      margin: EdgeInsets.all(10),
      child: TextField(
        focusNode: _focusNode,
        onSubmitted:(value) {
          _focusNode.unfocus();
        },
        
        decoration: InputDecoration(
          hintTextDirection: _words.language == 'ar'? TextDirection.rtl:TextDirection.ltr,
          prefixIcon:  Icon(Icons.search),
          labelText:widget.hint?? _words.searchhint(),
          border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffFF4100)))
        ),
      ),
    );
  }
  _changeFocus (){
    
  }
}