import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// define light theme data
ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.amber,
  accentColor: Colors.amberAccent,
  scaffoldBackgroundColor: Colors.white,
);

// define dark theme data
ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.amber,
  accentColor: Colors.black45,
);

//this class is for managing the app's theme
class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _prefs;
  late bool _darkTheme;

  //constructor
  ThemeNotifier() {
    _darkTheme = false;
    _initPrefs();
    _loadFromPrefs();
  }

  bool get darkTheme => _darkTheme;

  // this method toggles between the light and dark theme
  toggleTheme(){
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  // initialize shared preferences
  _initPrefs() async{
    _prefs = await SharedPreferences.getInstance();
  }

  // load the theme preference from shared preferences
  _loadFromPrefs() async{
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  // save the current theme preference to shared preferences
  _saveToPrefs() async{
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
