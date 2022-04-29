import 'package:e_commerce/Contraller/auth.dart';
import 'package:e_commerce/Widget/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'HomePage.dart';
class ForgetPassword extends StatefulWidget {
  static String id = "ForgetPassword";
  const ForgetPassword({Key? key}) : super(key: key);


  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  static String id = "ForgetPassword";
  TextEditingController? contraller = new TextEditingController();
  AuthContraller auth = new AuthContraller();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0 ?
              Padding(
                padding: EdgeInsets.only(top: 50),
                child : Center(
                  child: SvgPicture.asset(
                    "images/undraw_forgot_password_gi2d.svg",
                    width: 170,
                    height: 170,
                  ),
                ),
              ) : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomerTextField(
                  contraller: contraller,
                  prefixIconData: Icons.email,
                  scure: false,
                  hint: 'Enter your email .',
                  suffixIcon: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5 , top: 10),
                child: ElevatedButton( //ElevatedButton
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 45),
                    maximumSize: Size(350, 60),
                    primary: Colors.purple[700] ,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  onPressed: () async{
                    await auth.forgotPassword(contraller!.text);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      "Password reset email has been sent"
                    )));
                  },
                  child: Text(
                    "Reset Password" ,
                    textScaleFactor: 1.5,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
