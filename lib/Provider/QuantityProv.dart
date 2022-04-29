import 'package:flutter/cupertino.dart';

class QuantityProv extends ChangeNotifier{
  int quantity = 0;
   addQuantity(){
     quantity  ++;
     notifyListeners();
   }
   subQuantity(){
     quantity -- ;
     notifyListeners();
   }
}