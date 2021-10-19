import 'package:flutter/material.dart';
import 'package:notes_app_delthoid/themes/palette.dart';

var lightTheme = ThemeData(
  primaryColorLight: Colors.pink,
  brightness: Brightness.light,
  primaryColor: Colors.pink[50],
  fontFamily: 'Montserrat',
  backgroundColor: whiteSmoke,
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: Color(0XFFF5F5F5),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
  ),
);
