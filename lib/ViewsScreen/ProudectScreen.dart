import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:flutter/material.dart';
class ProductScreen extends StatelessWidget {
  static String id = "ProductScreen";
  Clothes model ;
  ProductScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          model.name ,
        ),
      ),
    );
  }
}
