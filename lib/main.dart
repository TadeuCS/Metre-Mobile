import 'package:flutter/material.dart';
import 'package:metre_mobile/screen/home_page.dart';
import 'package:metre_mobile/screen/login_page.dart';
import 'package:metre_mobile/screen/novo_item_page.dart';

void main() => runApp(
  MaterialApp(
    title: "Metre Mobile",
    debugShowCheckedModeBanner: false,
    initialRoute: "login",
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
      buttonColor: Colors.deepOrange,
      backgroundColor: Colors.white,
      cursorColor: Colors.deepOrangeAccent,
      indicatorColor: Colors.white,
      focusColor: Colors.white,
      hintColor: Colors.white
    ),
    routes: {
      "login": (context) => LoginPage(),
      "home": (context) => HomePage(),
      "itemPedido": (context) => NovoItemPage(),
    },
  )
);

