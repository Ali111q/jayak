import 'package:flutter/material.dart';
import 'package:jayak/utils/words.dart';

class LanguageController extends ChangeNotifier{
  
  Words words = Words('ar');
  
  void changeLanguage(String language){
    words.changeLanguage(language);
  }
}