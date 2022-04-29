import 'package:e_commerce/Contraller/auth.dart';
import 'package:e_commerce/Provider/Hub.dart';
import 'package:e_commerce/ViewsScreen/LogIn.dart';
import 'package:e_commerce/Widget/TextFormField.dart';
import 'package:e_commerce/Widget/customer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

class SignUp extends StatefulWidget {
  static String id = "SignUp";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static String id = "SignUp";
  AuthContraller auth = new AuthContraller();
  late String name , email , pass , confirmPass ;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context,listen: false).inAsyncCall,
            progressIndicator: SpinKitFadingCircle(color: Colors.purple.shade900,),
            child:Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment:
                      MediaQuery.of(context).viewInsets.bottom == 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        MediaQuery.of(context).viewInsets.bottom == 0 ?
                        Padding(
                          padding: EdgeInsets.only(top: 10 , bottom: 10),
                          child: Icon(FontAwesomeIcons.shopify , size: 130 , color: Colors.purple[900],),
                        ) : Container( height: 25,),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomerTextField(
                                prefixIconData : Icons.person,
                                hint : "Enter your Name",
                                scure :false,
                                suffixIcon : false,
                                onSaved: (v){
                                  name = v.toString();
                                },
                                validator: (v){
                                  if(v.toString().isNotEmpty){
                                    name = v.toString();
                                  }
                                  else return "Enter your Name";
                                },
                              ),
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
                                hint : "Enter Password",
                                scure : true,
                                suffixIcon : true,
                                suffixIconData : Icons.remove_red_eye_rounded,
                                onSaved: (v){
                                  pass = v.toString();
                                },
                                validator: (v){
                                  if(v.toString().length > 8){
                                    pass = v.toString();
                                  }
                                  else return "More than 8 digits";
                                },
                              ),
                              CustomerTextField(
                                prefixIconData : Icons.lock,
                                hint : "Confirm Password",
                                scure : true,
                                suffixIcon : true,
                                suffixIconData : Icons.remove_red_eye_rounded,
                                onSaved: (v){
                                  confirmPass = v.toString();
                                },
                                validator: (v){
                                  if(v.toString().length > 8){
                                    if(pass == v.toString()){
                                      confirmPass = v.toString();
                                    }
                                    else return "Password does not match" ;
                                  }
                                  else return "More than 8 digits";
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 5,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have account ?  " , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, LogIn.id);
                                },
                                child: Text("Login" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500 , color: Colors.black26),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5 , top: 5),
                          child:                     Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: UserButton(
                              title: 'Sign up',
                              method: ()async{
                                if(formKey.currentState!.validate()){
                                  formKey.currentState!.save();
                                  Provider.of<ModelHud>(context,listen: false).changeAsyncCall(true);
                                  try{
                                    await auth.signUp(email, pass, name);
                                    Navigator.pushNamed(context, HomePage.id);
                                  }catch(e){
                                    print(e);
                                  }
                                  Provider.of<ModelHud>(context,listen: false).changeAsyncCall(false);
                                }
                              },
                              color: Colors.deepPurple.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}