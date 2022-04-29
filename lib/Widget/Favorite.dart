import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:e_commerce/Provider/FavProv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late Clothes proudect ;
  @override
  Widget build(BuildContext context) {
    bool isDel = false ;
    return ListView.builder(
      itemCount: Provider.of<FavoriteProv>(context , listen: false).favProducts.length,
      itemBuilder: (BuildContext context, int index) {
        final item = Provider.of<FavoriteProv>(context , listen: false).favProducts[index];
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
              Provider.of<FavoriteProv>(context , listen: false).removeFromFavorite(item);
              item.fav = !item.fav ;
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
                        item.fav = !item.fav ;
                        Provider.of<FavoriteProv>(context , listen: false).addToFavorite(item);
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: .3 *  MediaQuery.of(context).size.width,
                  height: 120,
                  color: Colors.black,
                  child: Image.asset(
                    "images/${Provider.of<FavoriteProv>(context , listen: false).favProducts[index].image}.jpg",
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
                          Provider.of<FavoriteProv>(context , listen: false).favProducts[index].name ,
                          style: TextStyle(
                            fontFamily: "Pacifico",
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          Provider.of<FavoriteProv>(context , listen: false).favProducts[index].description,
                          style: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}