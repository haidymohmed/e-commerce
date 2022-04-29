import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeData extends ChangeNotifier{
  bool isDark = false ;
  changeTheme(){
    isDark = ! isDark ;
    notifyListeners();
  }
}