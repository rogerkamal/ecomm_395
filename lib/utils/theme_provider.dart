import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
    bool _isDark = false;

    bool get isDarkTheme => _isDark;


    set isDarkTheme(bool value){
      _isDark = value;
      notifyListeners();
    }

}
