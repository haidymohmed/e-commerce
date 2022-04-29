import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProv extends ChangeNotifier{
  late List<Clothes> favProducts = [];
  addToFavorite(product){
    favProducts.add(product);
    notifyListeners();
  }
  removeFromFavorite(product){
    favProducts.remove(product);
    notifyListeners();
  }
  bool ifExists(product){
    return favProducts.contains(product);
  }
}