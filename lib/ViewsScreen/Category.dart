import 'package:flutter/material.dart';
class Category extends StatefulWidget {
  static String id = "Category";
  late String title , image;
  Category(this.title , this.image);

  @override
  _CategoryState createState() => _CategoryState(this.title , this.image);
}

class _CategoryState extends State<Category> {
  static String id = "Category";
  late String title , image;
  _CategoryState(this.title , this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 70,
        title: Text(
          this.title ,
          style: TextStyle(
            fontFamily: "Pacifico",
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading:  InkWell(
          onTap: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back , size: 24, color: Colors.black,),
              CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("images/${this.image}.jpg")
              ),
            ],
          ),
        ),
      ),

    );
  }
}
