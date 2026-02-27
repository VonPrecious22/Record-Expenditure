import 'package:flutter/material.dart';
 ThemeData lightMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[600],
    displayColor: Colors.white
  )
 );