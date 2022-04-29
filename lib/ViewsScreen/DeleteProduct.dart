import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Contraller/ProductFB.dart';
import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DeleteProduct extends StatefulWidget {
  static String id  = "DeleteProduct";
  const DeleteProduct({Key? key}) : super(key: key);

  @override
  _DeleteProductState createState() => _DeleteProductState();
}
class _DeleteProductState extends State<DeleteProduct> {
  List<Clothes> products = [];
  ProductFB authProduct = new ProductFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: authProduct.getAllProduct(),
        builder: (context,snapShot) {
          print(snapShot.hasData);
          if(snapShot.hasData){
            products.clear();
            for(var doc in snapShot.data!.docs){
              products.add(
                  Clothes.modelSave(
                      name: doc.get('name'),
                      price: doc.get('price'),
                      description: doc.get('description'),
                      id: doc.get('id'),
                      image: doc.get('image'),
                      category: doc.get('category')
                  )
              );
            }
            return products.length > 0 ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context , index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Badge(
                      badgeColor: Colors.transparent,
                      elevation: 0,
                      position: BadgePosition(
                          top: 2,
                          end: 11
                      ),
                      badgeContent: InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (builder) {
                                return SimpleDialog(
                                  title: Text("Sure Delete ?"),
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SimpleDialogOption(
                                          child: Text(
                                              "Cancel",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          onPressed: (){
                                            Navigator.of(context).pop(context);
                                          },
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            "Delete " ,
                                            style: TextStyle(
                                                color: Colors.red.shade900,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          onPressed: (){
                                            authProduct.deleteProduct(products[index].id);
                                            Navigator.of(context).pop(context);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          child: Icon(Icons.delete , color: Colors.red,)
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                           Container(
                             height: MediaQuery.of(context).size.height * .4,
                             width: MediaQuery.of(context).size.width * .4,
                             child:  Image.network(
                                 products[index].image,
                               fit: BoxFit.fill,
                             ),
                           ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 8,
                                    right: 8,
                                    bottom: 8
                                  ),
                                  child: Text(
                                    products[index].name,
                                    style: TextStyle(
                                      fontSize: 15 ,
                                     ),
                                   ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      products[index].category ,
                                      style: TextStyle(
                                        fontSize: 15 ,
                                      ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    products[index].description,
                                    style: TextStyle(
                                      fontSize: 15 ,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      products[index].price + " LE",
                                    style: TextStyle(
                                      fontSize: 15 ,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            )
            :
            Container(
              child: Center(
                  child: Text(
                      "There are no products yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
              ),
            );
          }
          else return Container(
            child: Center(
                child: Text(
                  "There are no products yet",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
