import 'package:badges/badges.dart';
import 'package:e_commerce/Provider/AppThemeData.dart';
import 'package:e_commerce/Provider/CartProv.dart';
import 'package:e_commerce/Provider/Hub.dart';
import 'package:e_commerce/Widget/Card.dart';
import 'package:e_commerce/Widget/Favorite.dart';
import 'package:e_commerce/Widget/Home.dart';
import 'package:e_commerce/Widget/HomeDrawer.dart';
import 'package:e_commerce/Widget/Setting.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  static String id = "HomePage";
  List _screen = [Home() , MyCard() , Favorite() , Settings()];
  int index = 0 ;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  isSignUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isSign', true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignUp();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: key,
          drawer: HomeDrawer(),
          appBar: AppBar(
            backgroundColor: Provider.of<AppThemeData>(context).isDark ? Colors.grey.shade800:  Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: (){
                  key.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu , color: Colors.black,)
            ),
            actions: [
              Badge(
                position: BadgePosition(
                  top: 2,
                  end: 2
                ),
                badgeContent: Text(
                  Provider.of<CartProv>(context).cartList.length.toString() ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                  ),
                ),

                child: IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.add_shopping_cart_outlined ,
                      size: 25,
                      color: Provider.of<AppThemeData>(context).isDark ? Colors.white : Colors.grey.shade800 ,
                    )
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavyBar(
              onItemSelected: (int value) {
                setState(() {
                  index = value ;
                });
              },
              selectedIndex: index,
              items: [
                BottomNavyBarItem(
                   icon: Icon(Icons.home),
                   title: Text("Home"),
                   activeColor: Colors.purple.shade700,
                  inactiveColor: Colors.black,
                ),

                BottomNavyBarItem(
                  icon: Icon(Icons.add_shopping_cart_outlined),
                  title: Text("Card"),
                  activeColor: Colors.purple.shade700,
                  inactiveColor: Colors.black,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text("Fav"),
                  activeColor: Colors.purple.shade700,
                  inactiveColor: Colors.red[900],
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.settings_sharp),
                  title: Text("Settings"),
                  activeColor: Colors.purple.shade700,
                  inactiveColor: Colors.black,
                ),
              ],
            ),
          body:  ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context,listen: false).inAsyncCall,
            progressIndicator: SpinKitFadingCircle(color: Colors.purple.shade900,),
            child:  Column(
              children: [
                Expanded(
                  child: _screen[index],
                )
              ],
            ),
          )
        ),
    );
  }
}

