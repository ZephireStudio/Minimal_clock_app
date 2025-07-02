import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier{
  bool _AlwaysOnTop = false;
  bool get alwaysontop => _AlwaysOnTop;

  void toggleAlwaysOnTop(bool value){
    _AlwaysOnTop = value;
    notifyListeners();
  }
}