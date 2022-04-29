import 'package:e_commerce/ViewsScreen/AddProduct.dart';
import 'package:e_commerce/ViewsScreen/DeleteProduct.dart';
import 'package:e_commerce/Widget/customer_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  static final  String id = 'AdminLogin';
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserButton(
                  title: 'Add Product',
                  color: Colors.purple,
                  method: (){
                    Navigator.pushNamed(context, AddProduct.id);
                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserButton(
                  title: 'Delete Product',
                  color: Colors.purple,
                  method: (){
                    Navigator.pushNamed(context, DeleteProduct.id);
                  },

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
