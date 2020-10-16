import 'package:flutter/material.dart';
import 'package:flutter_app_buscador_giphys/views/HomePage.dart';
import 'package:flutter_app_buscador_giphys/views/Git_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    //home:GifPage(),
    theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white),
        )),
  ));
}
