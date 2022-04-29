import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool  inAsyncCall = false ;
  changeAsyncCall(bool value){
    inAsyncCall = value;
    notifyListeners();
  }
}