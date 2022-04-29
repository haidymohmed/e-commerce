import 'package:e_commerce/ViewsScreen/HomePage.dart';
import 'package:e_commerce/ViewsScreen/LogIn.dart';
import 'package:e_commerce/ViewsScreen/OnBoardingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashingScreen extends StatefulWidget {
  const SplashingScreen({Key? key}) : super(key: key);

  @override
  _SplashingScreenState createState() => _SplashingScreenState();
}

class _SplashingScreenState extends State<SplashingScreen> {
  bool firstTime = true;
  bool isSign = false;
  checkFirst() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      firstTime = sharedPreferences.getBool('first')!;
    });
  }
  checkSign() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isSign = sharedPreferences.getBool('isSign')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirst();
    checkSign();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: firstTime ? OnBoardingScreen() : isSign ? HomePage() : LogIn(),
      splash: Icon(FontAwesomeIcons.shopify , size: 150,color: Colors.purple.shade700,),
    );
  }
}