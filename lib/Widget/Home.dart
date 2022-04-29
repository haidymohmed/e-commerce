import 'package:badges/badges.dart';
import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:e_commerce/Models/Data.dart';
import 'package:e_commerce/Provider/AppThemeData.dart';
import 'package:e_commerce/Provider/FavProv.dart';
import 'package:e_commerce/ViewsScreen/Category.dart';
import 'package:e_commerce/ViewsScreen/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  bool tapped = false;
  List<Clothes> model1 = [
    Clothes.model1(image: "model2_5" , name: 'Shirts'),
    Clothes.model1(image: "model1_6" , name: 'Watches'),
    Clothes.model1(image: "model1_3" , name: 'Bags'),
    Clothes.model1(image: "model1_4" , name: 'Shoes'),
    Clothes.model1(image: "model1_2" , name: 'Clothes'),
    Clothes.model1(image: "model1_5" , name: 'Trouser'),
    Clothes.model1(image: "model1_1" , name: 'Hat'),
  ];
  late List<Clothes> model2 ;
  late List<Clothes> model3 ;
  @override
  Widget build(BuildContext context) {
    model2 = Provider.of<DataProv>(context).model2;
    model3 = Provider.of<DataProv>(context).model3;
    return ListView(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
              right: 30,
              top: 10,
              left: 30
            ),
            height: 45,
            decoration: BoxDecoration(
              color: Provider.of<AppThemeData>(context).isDark ? Colors.grey.shade800 :  Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(Icons.search , color: Colors.black,),
                ),
                Spacer()
              ],
            )
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount : model1.length ,
            itemBuilder: (context , index){
              return InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Category(this.model1[index].name , this.model1[index].image))
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: 65,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("images/${model1[index].image}.jpg"),
                      ),
                      SizedBox(height: 7),
                      Text(model1[index].name , style: TextStyle(fontSize: 10 , fontFamily: "Pacifico"),)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            right: 15,
            left: 15
          ),
          height: 30,
          child: Row(
            children: [
              Text("New Arrival" , style: TextStyle(fontWeight: FontWeight.w600 , )),
              Spacer(),
              InkWell(
                onTap: (){ },
                child:  Container(
                  padding: EdgeInsets.only(right: 6),
                  width: 80,
                  height: 30,
                  child: Row(
                    children: [
                      Text("See All" ,style: TextStyle(fontWeight: FontWeight.w600 , ) ),
                      Icon(Icons.arrow_forward_ios_sharp , size: 15,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount : 5 ,
            itemBuilder: (context , index){
              return Badge(
                badgeColor: Colors.white,
                position: BadgePosition(
                    top: 2,
                    end: 11
                ),
                badgeContent: InkWell(
                  onTap: (){
                    setState(() {
                      this.model2[index].fav ?
                        Provider.of<FavoriteProv>(context , listen: false).removeFromFavorite(this.model2[index]) :
                        Provider.of<FavoriteProv>(context , listen: false).addToFavorite(this.model2[index]);

                      this.model2[index].fav = ! this.model2[index].fav;
                    });
                  },
                  child: Provider.of<FavoriteProv>(context , listen: false).favProducts.length == 0 || this.model2[index].fav == false ?
                  Icon(Icons.favorite_outline_sharp,color: Colors.red) : Icon(Icons.favorite , color: Colors.red,)
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductModel1(model: this.model2[index],))
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width:  180,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 160,
                          height: 180,
                          child: Image.asset(
                            "images/model2_${index+1}.jpg"
                          ),
                        ),
                        Spacer(),
                        Text(model2[index].name, style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w600)),
                        Spacer(),
                        Text(model2[index].description, style: TextStyle(fontSize: 15 , color: Colors.grey[500])),
                        Spacer(),
                        Text("${model2[index].price} L.E" , style: TextStyle(fontSize: 13 , color: Provider.of<AppThemeData>(context).isDark ? Colors.deepPurple.shade100 : Colors.purple.shade900),),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 200,
          child: Swiper(
            itemCount: 7,
            pagination: SwiperPagination(),
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 3,
                  right: 3
                ),
                child: Container(
                  height: 200,
                  child: Image.asset(
                    "images/swiper${index+1}.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    height: 190,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 15,
              left: 15
          ),
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.price_check ,color: Colors.deepPurple,),

              Text("Hot Price" , style: TextStyle(fontWeight: FontWeight.w600 , )),
             ]
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getModel(0),
            getModel(1)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getModel(2),
            getModel(3)
          ],
        ),
      ],
    );
  }
  Widget getModel (int index){
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ProductModel1(model: this.model3[index])
            )
        );
      },
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(5),
        width:  .45 * MediaQuery.of(context).size.width,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              width:  .45 * MediaQuery.of(context).size.width,
              height: 180,
              child: Image.asset(
                  "images/model3_${index+1}.jpg",
                width: .5 * MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: 180,
              ),
            ),
            Spacer(),
            Text(model2[index].name, style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w600)),
            Spacer(),
            Text(model2[index].description, style: TextStyle(fontSize: 15 , color: Colors.grey[500])),
            Spacer(),
            Text("${model2[index].price} L.E" , style: TextStyle(fontSize: 13 , color: Provider.of<AppThemeData>(context).isDark ? Colors.deepPurple.shade100 : Colors.purple.shade900),),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
