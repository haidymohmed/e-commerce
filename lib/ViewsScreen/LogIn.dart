import 'package:e_commerce/Contraller/auth.dart';
import 'package:e_commerce/Provider/Hub.dart';
import 'package:e_commerce/ViewsScreen/ForgetPassword.dart';
import 'package:e_commerce/ViewsScreen/SignUp.dart';
import 'package:e_commerce/Widget/DisplayDialogMessage.dart';
import 'package:e_commerce/Widget/TextFormField.dart';
import 'package:e_commerce/Widget/customer_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'AdminHome.dart';
import 'HomePage.dart';
class LogIn extends StatefulWidget {
  static String id = "SignIn";
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin{
  late String email , password;
  AuthContraller auth = AuthContraller();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static String id = "SignIn";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ModalProgressHUD(
              inAsyncCall: Provider.of<ModelHud>(context).inAsyncCall,
              progressIndicator: SpinKitFadingCircle(color: Colors.purple.shade900,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.purple.shade900,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomerTextField(
                            prefixIconData : Icons.email,
                            hint : "Enter your Email",
                            scure :false,
                            suffixIcon : false,
                            onSaved: (v){
                              email = v.toString();
                            },
                            validator: (v){
                              if(v.toString().isNotEmpty){
                                email = v.toString();
                              }
                              else return "Enter your Email";
                            },
                          ),
                          CustomerTextField(
                            prefixIconData : Icons.lock,
                            hint : "Enter your Password",
                            scure : true,
                            suffixIcon : true,
                            suffixIconData : Icons.remove_red_eye_rounded,
                            onSaved: (v){
                              password = v.toString();
                            },
                            validator: (v){
                              if(v.toString().length > 8){
                                password = v.toString();
                              }
                              else return "Enter your Password";
                            },
                          ),
                        ],
                      )
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, ForgetPassword.id);
                        },
                        child: Text(
                          "Forget password ? ",
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserButton(
                      title: 'LOGIN',
                      method: ()async{
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          Provider.of<ModelHud>(context,listen: false).changeAsyncCall(true);
                          try{
                            await auth.logIn(email, password);
                            Navigator.pushNamedAndRemoveUntil(context,HomePage.id, (route) => false);
                          }catch(e){
                            DisplayDialogMessage(context , e.toString());
                          }
                          Provider.of<ModelHud>(context,listen: false).changeAsyncCall(false);
                        }
                      },
                      color: Colors.deepPurple.shade900,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?  " , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, SignUp.id);
                          },
                          child: Text("SignUp" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500 , color: Colors.black26),),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10
                        ),
                        child: InkWell(
                          onTap: ()async{
                            try{
                              Provider.of<ModelHud>(context,listen: false).changeAsyncCall(true);
                              await auth.logInWithGoogle();
                              Navigator.pushNamedAndRemoveUntil(context,AdminLogin.id, (route) => false);
                            }catch(e){
                              DisplayDialogMessage(context , e.toString());
                            }
                            Provider.of<ModelHud>(context,listen: false).changeAsyncCall(false);
                          },
                          child: const Icon(FontAwesomeIcons.google,color: Colors.red,size: 30,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10
                        ),
                        child: InkWell(
                          onTap: ()async{
                            try{
                              Provider.of<ModelHud>(context,listen: false).changeAsyncCall(true);
                              await auth.logInWithFacebook();
                              Navigator.pushNamedAndRemoveUntil(context,HomePage.id, (route) => false);
                            }catch(e){DisplayDialogMessage(context , e.toString());
                            }
                            Provider.of<ModelHud>(context,listen: false).changeAsyncCall(false);
                          },
                          child: const Icon(FontAwesomeIcons.facebook,color: Colors.blue,size: 30,),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }
}