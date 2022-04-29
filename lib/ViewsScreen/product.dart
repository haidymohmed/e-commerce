import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:e_commerce/Provider/CartProv.dart';
import 'package:e_commerce/Provider/FavProv.dart';
import 'package:e_commerce/Provider/QuantityProv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProductModel1 extends StatefulWidget {
  Clothes model ;
  ProductModel1({required this.model});
  @override
  _ProductModel1State createState() => _ProductModel1State(this.model);
}
class _ProductModel1State extends State<ProductModel1> {
  Clothes model ;
  _ProductModel1State(this.model);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: .6 *  MediaQuery.of(context).size.height,
              child: Image.asset(
                "images/${this.model.image}.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20 ,
                vertical: 10
              ),
              child: Row(
                children: [
                  Text(model.name, style: TextStyle(fontFamily: "Pacifico",fontSize: 20,fontWeight: FontWeight.w400)),
                  Spacer(),
                    InkWell(
                    onTap: (){
                      setState(() {
                        this.model.fav ?
                          Provider.of<FavoriteProv>(context , listen: false).removeFromFavorite(model) :
                          Provider.of<FavoriteProv>(context , listen: false).addToFavorite(model);

                        this.model.fav = ! this.model.fav;
                      });
                    },
                    child: Icon(
                      model.fav ?
                      Icons.favorite : Icons.favorite_outline_sharp,
                      color: Colors.red,
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 ,
                  vertical: 10
              ),
              child: Align(
                alignment: Alignment.topLeft,
                  child: Text(
                      model.description,
                      style: TextStyle(
                          fontFamily: "SourceSansPro",
                          fontSize: 16 ,
                          fontWeight: FontWeight.w700
                      )
                  )
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<QuantityProv>(
                    builder: (context , data , child)=>  InkWell(
                      onTap: (){
                        setState(() {
                          data.addQuantity();
                          this.model.quantity = data.quantity;
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                  Consumer<QuantityProv>(
                    builder: (context , data , child)=> Text(
                      "  ${data.quantity}  ",
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20
                      ),
                    ),
                  ),
                  Consumer<QuantityProv>(
                    builder: (context , data , child)=>
                    InkWell(
                        onTap: (){
                        setState(() {
                          if(model.quantity > 1){
                            data.subQuantity();
                            this.model.quantity = data.quantity;
                          }
                          else{
                            this.model.quantity = data.quantity;
                          }
                        });
                       },
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.remove),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20 ,
                  vertical: 10
              ),
              child: Row(
                children: [
                  Text("${model.price}  L.E" , style: TextStyle(fontFamily: "Pacifico",fontSize: 20 ) ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 20,
                        right: 20
                      ),
                      primary: Colors.purple[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                      onPressed: (){
                        Provider.of<CartProv>(context , listen: false).addToCart(this.model);
                        Provider.of<QuantityProv>(context , listen: false).quantity = 0;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                        Row(
                          children: [
                            Text("Added to cart"),
                          ],
                        ),
                        ));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add Card" , style: TextStyle(fontFamily: "Pacifico" , fontSize: 15),),
                        ],
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
