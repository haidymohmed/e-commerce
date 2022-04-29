import 'package:e_commerce/Contraller/auth.dart';
import 'package:e_commerce/Provider/AppThemeData.dart';
import 'package:e_commerce/Provider/Hub.dart';
import 'package:e_commerce/ViewsScreen/HomePage.dart';
import 'package:e_commerce/ViewsScreen/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeDrawer extends StatefulWidget {
  static String id = "HomeDrawer";
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  AuthContraller authContraller = new AuthContraller();
  // ignore: non_constant_identifier_names
  SignUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isSign', false);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                            "Change Theme",
                          style: TextStyle(
                            fontFamily: "Pacifico",
                            fontSize: 20
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: Provider.of<AppThemeData>(context).isDark,
                          onChanged: (bool x) {
                            setState(() {
                              Provider.of<AppThemeData>(context , listen: false).changeTheme();
                              print(Provider.of<AppThemeData>(context , listen: false).isDark);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/girl.jpg"),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Haidy Mohmed",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      bottom: 8
                    ),
                    child: Text(
                        "+028348479194",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.grey.shade300,
                  ),
                  InkWell(
                    onTap: ()async{
                      try{
                        Provider.of<ModelHud>(context,listen: false).changeAsyncCall(true);
                        await authContraller.signOut();
                        await SignUp();
                        Provider.of<ModelHud>(context,listen: false).changeAsyncCall(false);
                        Navigator.pushNamedAndRemoveUntil(context, LogIn.id, (route) => false);
                      }catch(e){
                        print("Error");
                        print(e );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "Log out",
                            style: TextStyle(
                                fontSize: 18
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.logout
                          ),
                        )
                      ],
                    ),
                  )
                ],

              ),
            ],
          ),
        )
    );
  }
}
