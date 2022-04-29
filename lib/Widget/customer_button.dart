import 'package:flutter/material.dart';
class UserButton extends StatefulWidget {
  final Function method ;
  final Color color ;
  final String title ;

  const UserButton({required this.title ,required this.color ,required this.method});

  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: .8 *  MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: widget.color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color : widget.color == Colors.transparent ?  Colors.white : widget.color , width: 2) ,
                borderRadius: BorderRadius.circular(50),
              )
          ),
          onPressed: (){
            widget.method();
          },
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600
            ),
          )
      ),
    );
  }
}
