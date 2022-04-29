import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomerTextField extends StatefulWidget {
  TextEditingController? contraller = new TextEditingController();
  late String hint ;
  IconData? prefixIconData ;
  IconData? suffixIconData ;
  late bool scure , suffixIcon ;
  var validator , onSaved , onTap ;
  CustomerTextField(
      {
      required this.hint,
      required this.scure,
      required this.suffixIcon,
      this.suffixIconData,
      this.contraller ,
      this.onTap,
      this.onSaved,
      this.validator,
      this.prefixIconData,
      });
  @override
  _CustomerTextFieldState createState() => _CustomerTextFieldState();
}

class _CustomerTextFieldState extends State<CustomerTextField> {
  _CustomerTextFieldState();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5 , bottom: 5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Colors.grey.shade200
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      height: 50,
      width: .9 *  MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: widget.contraller,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onTap: widget.onTap,
        obscureText: widget.scure ,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon( widget.prefixIconData , size: 25, color: Colors.deepPurple.shade900,),
          ),
          suffixIcon: getIcon(widget.suffixIcon),
          border: const OutlineInputBorder(
              borderSide: BorderSide.none
          ),
        ),

      ),
    );
  }
  IconButton? getIcon(bool isSuffix){
    if(isSuffix){
      return IconButton(
        onPressed: () {
          setState(() {
            widget.scure = ! widget.scure;
          });
        },
        icon: Icon(
          widget.suffixIconData ,
          color: Colors.grey,
          size: 20,
        ),
      );
    }
    else{
      return null;
    }
  }
}