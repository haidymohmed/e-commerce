import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:e_commerce/ViewsScreen/DeleteProduct.dart';

class ProductFB{
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  addProduct(Clothes product) async{
    await products.doc(product.id).set(product.toJson());
  }
  getAllProduct(){
    return products.snapshots();
  }
  deleteProduct(String id){
    products.doc(id).delete();
  }
}