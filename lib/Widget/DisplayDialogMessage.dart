import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: non_constant_identifier_names
Future<dynamic> DisplayDialogMessage(BuildContext context , String text) {
    return showDialog(
        context: context,
        builder: (_)=> CupertinoAlertDialog(
          content: Text(text),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
        barrierDismissible: true
    );
  }

