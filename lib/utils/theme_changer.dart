import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier{
  ThemeData _themeData;
  ThemeChanger(this._themeData);
  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}

//shared preferences functions

setThemeToSP(value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('colorNum', value); // maybe await??

}


getThemeFromSP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int colorNumFromSP = prefs.getInt('colorNum');
  debugPrint('theme change file sent this ---> '+ colorNumFromSP.toString() );
  return colorNumFromSP ?? 0;
}
