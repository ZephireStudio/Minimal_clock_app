import 'package:flutter/material.dart';
import 'package:minimal_clock/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themedata = lightMode;

  ThemeData get themeData => _themedata;

  set themeData(ThemeData themeData){
    _themedata = themeData;
    notifyListeners();
  }

  void toggle(){
    if (_themedata.brightness == Brightness.light){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }
}