import 'package:e_commerce/Provider/AppThemeData.dart';
import 'package:e_commerce/ViewsScreen/AddProduct.dart';
import 'package:e_commerce/ViewsScreen/DeleteProduct.dart';
import 'package:e_commerce/ViewsScreen/SplashingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/ClothesModel1.dart';
import 'Models/Data.dart';
import 'Provider/CartProv.dart';
import 'Provider/FavProv.dart';
import 'Provider/Hub.dart';
import 'Provider/QuantityProv.dart';
import 'ViewsScreen/AdminHome.dart';
import 'ViewsScreen/ForgetPassword.dart';
import 'ViewsScreen/HomePage.dart';
import 'ViewsScreen/LogIn.dart';
import 'ViewsScreen/OnBoardingScreen.dart';
import 'ViewsScreen/SignUp.dart';
import 'Widget/HomeDrawer.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppThemeData()),
        ChangeNotifierProvider(create: (context) => CartProv()),
        ChangeNotifierProvider(create: (context) => QuantityProv()),
        ChangeNotifierProvider(create: (context) => FavoriteProv()),
        ChangeNotifierProvider(create: (context) => DataProv()),
        ChangeNotifierProvider(create: (context) => ModelHud()),
      ],
      child: ECommerce()
    )
  );
}
class ECommerce extends StatefulWidget {
  @override
  State<ECommerce> createState() => _ECommerceState();
}

class _ECommerceState extends State<ECommerce> {
  Clothes m = Clothes.model2(image : "model1_2", name : "Olives" , description : "The first time the widget is laid out. When the parent widget passes different layout constraints.When the parent widget updates this widget.When the dependencies that the builder function subscribes to change." , price : "4500" , fav: false, quantity: 1 );

  @override
  Widget build(BuildContext context){
    return MediaQuery(
      data: MediaQueryData(),
      child:  MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.purple.shade900,
            brightness: Provider.of<AppThemeData>(context).isDark ? Brightness.dark : Brightness.light ,
          ),
          title: "E - Commerce",
          debugShowCheckedModeBanner: false,
          routes: {
            OnBoardingScreen.id : (context) => OnBoardingScreen(),
            LogIn.id : (context)=> LogIn(),
            ForgetPassword.id : (context) => ForgetPassword(),
            SignUp.id : (context) => SignUp(),
            HomeDrawer.id : (context) => HomeDrawer(),
            HomePage.id : (context) => HomePage(),
            AdminLogin.id : (context) => AdminLogin(),
            AddProduct.id : (context) => AddProduct(),
            DeleteProduct.id : (context) => DeleteProduct(),
          },
          home: SplashingScreen()
      ),
    );
  }
}