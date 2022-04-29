import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:flutter/cupertino.dart';

class CartProv extends ChangeNotifier{
   List<Clothes> cartList = [];
  addToCart(product){
    cartList.add(product);
    notifyListeners();
  }
   removeToCart(product){
     cartList.remove(product);
     notifyListeners();
   }
}