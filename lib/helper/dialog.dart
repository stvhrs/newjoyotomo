import 'package:flutter/material.dart';

 dialog(
    {required Function onClickAction,
    required String string,
    required BuildContext context}) {
  return AlertDialog(
        title: Text(string),
        actions: [
          IconButton(
            onPressed: () {
              onClickAction();
         
              Navigator.of(context).pop(true);
             
              
            },
            icon: Icon(Icons.check_box),
          )
        ],
      );
    }
 

