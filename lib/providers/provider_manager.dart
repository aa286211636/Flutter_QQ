import 'package:flutter/material.dart';

//改变主题
class ThemeProvider with ChangeNotifier {
  Color _themecolor;
  ThemeProvider(this._themecolor);

  void changeTheme(color) {
    notifyListeners();
    _themecolor = color;
  }

  get themecolor => _themecolor;

  get theme => ThemeData(primaryColor: _themecolor);

}
