import 'package:flutter/material.dart';
import 'package:metre_mobile/screen/home.dart';
import 'package:metre_mobile/screen/login.dart';

void main() => runApp(
  MaterialApp(
    title: "Metre Mobile",
    debugShowCheckedModeBanner: false,
    initialRoute: "login",
    theme: ThemeData(
      primaryColor: Colors.deepOrange,
      buttonColor: Colors.deepOrangeAccent
    ),
    routes: {
      "login": (context) => Login(),
      "home": (context) => Home(),
    },
  )
);

