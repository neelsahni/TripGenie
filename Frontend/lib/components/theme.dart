import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light_mode = ThemeData(
  brightness: Brightness.light,
);

ThemeData dark_mode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _preferences;
  late bool _darkMode;

  bool get darkMode => _darkMode;

  ThemeNotifier() {
    _darkMode = true;
    _loadFromPreferences();
  }


  _initialPreferences() async {
    //if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? true;
    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
