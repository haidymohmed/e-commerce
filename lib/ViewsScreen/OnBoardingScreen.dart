import 'package:e_commerce/ViewsScreen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LogIn.dart';

class OnBoardingScreen extends StatefulWidget {
  static String id = "OnBoardingScreen";
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  firstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('first', false);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, LogIn.id);
          },
          child: Text(
            "TO Sign In"
          ),
        )
      ),
    );
  }
}
