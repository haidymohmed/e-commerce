import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:e_commerce/Provider/CartProv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MyCard extends StatefulWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  late Clothes proudect ;
  @override
  Widget build(BuildContext context) {
    bool isDel = false ;
    return ListView.builder(
      itemCount: Provider.of<CartProv>(context , listen: false).cartList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = Provider.of<CartProv>(context , listen: false).cartList[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: ValueKey(item),
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete ,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction){
            setState(() {
              Provider.of<CartProv>(context , listen: false).removeToCart(item);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Row(
                  children: [
                    Text("Item has been removed"),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        setState(() {
                          if(! isDel)  {
                             Provider.of<CartProv>(context , listen: false).addToCart(item);
                             isDel = ! isDel;
                          }
                          else
                            null ;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2 , color: Colors.blue)
                          )
                        ),
                        child: Text(
                          "Undo",
                          style: TextStyle(
                              color: Colors.blue
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: .3 * MediaQuery.of(context).size.width,
                  height: 120,
                  color: Colors.black,
                  child: Image.asset(
                      "images/${Provider.of<CartProv>(context , listen: false).cartList[index].image}.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Provider.of<CartProv>(context , listen: false).cartList[index].name ,
                          style: TextStyle(
                            fontFamily: "Pacifico",
                            fontSize: 20
                          ),
                        ),
                        Text(
                          Provider.of<CartProv>(context , listen: false).cartList[index].description,
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Provider.of<CartProv>(context , listen: false).cartList[index].quantity.toString(),
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
/*
direction: DismissDirection.endToStart,
          key: ValueKey(key),
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete ,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction){
            setState(() {
              Provider.of<CartProv>(context , listen: false).removeToCart(Provider.of<CartProv>(context , listen: false).cartList[index]);
            });
          },
 */