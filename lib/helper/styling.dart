import 'package:flutter/material.dart';

var input=const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
       
        hintText: "Cari Nama");

         inputNone(String s)=>const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,hintStyle: TextStyle(fontSize: 10),errorStyle: TextStyle(fontSize: 10),labelStyle: TextStyle(fontSize: 10),helperStyle: TextStyle(fontSize: 10),
        enabledBorder: InputBorder.none,prefixStyle: TextStyle(fontSize: 10),suffixStyle: TextStyle(fontSize: 10),counterStyle: TextStyle(fontSize: 10),floatingLabelStyle: TextStyle(fontSize: 10),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
       
        hintText: "s");